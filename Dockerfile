FROM caddy:2.4.6-builder-alpine AS builder

RUN xcaddy build \
  --with github.com/caddyserver/format-encoder \
  --with github.com/gamalan/caddy-tlsredis \
  --with github.com/kirsch33/realip \
  --with github.com/greenpau/caddy-auth-portal@latest \
  --with github.com/greenpau/caddy-authorize@latest \
  --with github.com/caddy-dns/cloudflare \
  --with github.com/caddy-dns/digitalocean \
  --with github.com/caddy-dns/route53 \
  --with github.com/caddy-dns/duckdns \
  --with github.com/caddy-dns/namecheap \
  --with github.com/caddy-dns/alydns \
  --with github.com/caddy-dns/dnspod


FROM caddy:2.4.6-alpine

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

CMD ["caddy", "run", "--environ", "--config", "/etc/caddy/Caddyfile", "--adapter", "caddyfile"]

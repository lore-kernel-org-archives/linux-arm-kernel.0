From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 4 Oct 2011 09:34:04 +0200
Subject: [PATCH] ARM: remove bashism in check for multiple zreladdrs
In-Reply-To: <1317660736-19081-1-git-send-email-rabin@rab.in>
References: <1317660736-19081-1-git-send-email-rabin@rab.in>
Message-ID: <20111004073404.GI31404@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 03, 2011 at 10:22:16PM +0530, Rabin Vincent wrote:
> Get rid of this complaint from dash:
> 
>     AS      arch/arm/boot/compressed/lib1funcs.o
>   /bin/sh: 1: [: y: unexpected operator
>     LD      arch/arm/boot/compressed/vmlinux
> 
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Signed-off-by: Rabin Vincent <rabin@rab.in>

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

I guess using '=' for a comparison is hard to type for a C programmer ;)

Sascha

> ---
>  arch/arm/boot/compressed/Makefile |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
> index a53a333..a6b30b3 100644
> --- a/arch/arm/boot/compressed/Makefile
> +++ b/arch/arm/boot/compressed/Makefile
> @@ -140,7 +140,7 @@ bad_syms=$$($(CROSS_COMPILE)nm $@ | sed -n 's/^.\{8\} [bc] \(.*\)/\1/p') && \
>      echo "$$bad_syms" >&2; rm -f $@; false )
>  
>  check_for_multiple_zreladdr = \
> -if [ $(words $(ZRELADDR)) -gt 1 -a "$(CONFIG_AUTO_ZRELADDR)" == "" ]; then \
> +if [ $(words $(ZRELADDR)) -gt 1 -a "$(CONFIG_AUTO_ZRELADDR)" = "" ]; then \
>  	echo 'multiple zreladdrs: $(ZRELADDR)'; \
>  	echo 'This needs CONFIG_AUTO_ZRELADDR to be set'; \
>  	false; \
> -- 
> 1.7.5.4
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

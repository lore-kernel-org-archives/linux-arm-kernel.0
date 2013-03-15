From: timo.t.kokkonen@iki.fi (Timo Kokkonen)
Date: Fri, 15 Mar 2013 08:39:13 +0200
Subject: [PATCH] [media] ir: IR_RX51 only works on OMAP2
In-Reply-To: <1363298204-8014-7-git-send-email-arnd@arndb.de>
References: <1363298204-8014-1-git-send-email-arnd@arndb.de>
 <1363298204-8014-7-git-send-email-arnd@arndb.de>
Message-ID: <20130315063913.GC1638@itanic.dhcp.inet.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03.14 2013 22:56:44, Arnd Bergmann wrote:
> This driver can be enabled on OMAP1 at the moment, which breaks
> allyesconfig for that platform. Let's mark it OMAP2PLUS-only
> in Kconfig, since that is the only thing it builds on.
> 

Acked-by: Timo Kokkonen <timo.t.kokkonen@iki.fi>

Thanks!

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Mauro Carvalho Chehab <mchehab@redhat.com>
> Cc: Timo Kokkonen <timo.t.kokkonen@iki.fi>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: linux-media at vger.kernel.org
> ---
> Mauro, please apply for 3.9
> 
>  drivers/media/rc/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/rc/Kconfig b/drivers/media/rc/Kconfig
> index 19f3563..5a79c33 100644
> --- a/drivers/media/rc/Kconfig
> +++ b/drivers/media/rc/Kconfig
> @@ -291,7 +291,7 @@ config IR_TTUSBIR
>  
>  config IR_RX51
>  	tristate "Nokia N900 IR transmitter diode"
> -	depends on OMAP_DM_TIMER && LIRC && !ARCH_MULTIPLATFORM
> +	depends on OMAP_DM_TIMER && ARCH_OMAP2PLUS && LIRC && !ARCH_MULTIPLATFORM
>  	---help---
>  	   Say Y or M here if you want to enable support for the IR
>  	   transmitter diode built in the Nokia N900 (RX51) device.
> -- 
> 1.8.1.2
> 

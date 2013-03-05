From: balbi@ti.com (Felipe Balbi)
Date: Tue, 5 Mar 2013 13:36:18 +0200
Subject: [PATCH] ARM: OMAP: RX-51: add missing USB phy binding
In-Reply-To: <1362481780-11018-1-git-send-email-aaro.koskinen@iki.fi>
References: <1362481780-11018-1-git-send-email-aaro.koskinen@iki.fi>
Message-ID: <20130305113618.GB19290@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 05, 2013 at 01:09:40PM +0200, Aaro Koskinen wrote:
> Commit 51482be9 (ARM: OMAP: USB: Add phy binding information) forgot to
> add phy binding for RX-51, and as a result USB does not work anymore on
> 3.9-rc1. Add the missing binding.
> 
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>

Acked-by: Felipe Balbi <balbi@ti.com>

> ---
>  arch/arm/mach-omap2/board-rx51.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
> index f7c4616..d2ea68e 100644
> --- a/arch/arm/mach-omap2/board-rx51.c
> +++ b/arch/arm/mach-omap2/board-rx51.c
> @@ -17,6 +17,7 @@
>  #include <linux/io.h>
>  #include <linux/gpio.h>
>  #include <linux/leds.h>
> +#include <linux/usb/phy.h>
>  #include <linux/usb/musb.h>
>  #include <linux/platform_data/spi-omap2-mcspi.h>
>  
> @@ -98,6 +99,7 @@ static void __init rx51_init(void)
>  	sdrc_params = nokia_get_sdram_timings();
>  	omap_sdrc_init(sdrc_params, sdrc_params);
>  
> +	usb_bind_phy("musb-hdrc.0.auto", 0, "twl4030_usb");
>  	usb_musb_init(&musb_board_data);
>  	rx51_peripherals_init();
>  
> -- 
> 1.7.10.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130305/e19e9ba6/attachment.sig>

From: tony@atomide.com (Tony Lindgren)
Date: Thu, 8 Dec 2011 16:37:44 -0800
Subject: [RFC/PATCH] ARM: OMAP2+: Add chip_select to ads7846 init
In-Reply-To: <1320358999-11016-1-git-send-email-weber@corscience.de>
References: <1320358999-11016-1-git-send-email-weber@corscience.de>
Message-ID: <20111209003744.GH31337@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Thomas Weber <weber@corscience.de> [111103 13:46]:
> This patch adds the chip_select as parameter to
> omap_ads7846_init.
> All existing omap2-boards use chip select 0 on
> different spi busses. I work on bringing a board
> mainline where the ads7846 is connected to
> chip select 1. This patch prepares the omap_ads7846_init
> function for this board.
> 
> Signed-off-by: Thomas Weber <weber@corscience.de>
> ---
>  arch/arm/mach-omap2/board-3430sdp.c        |    2 +-
>  arch/arm/mach-omap2/board-cm-t35.c         |    2 +-
>  arch/arm/mach-omap2/board-devkit8000.c     |    2 +-
>  arch/arm/mach-omap2/board-ldp.c            |    2 +-
>  arch/arm/mach-omap2/board-omap3evm.c       |    2 +-
>  arch/arm/mach-omap2/board-omap3pandora.c   |    2 +-
>  arch/arm/mach-omap2/board-omap3stalker.c   |    2 +-
>  arch/arm/mach-omap2/board-omap3touchbook.c |    2 +-
>  arch/arm/mach-omap2/board-overo.c          |    2 +-
>  arch/arm/mach-omap2/common-board-devices.c |   13 ++++++++-----
>  arch/arm/mach-omap2/common-board-devices.h |    3 ++-
>  11 files changed, 19 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
> index 77142c1..dec6407 100644
> --- a/arch/arm/mach-omap2/board-3430sdp.c
> +++ b/arch/arm/mach-omap2/board-3430sdp.c
> @@ -710,7 +710,7 @@ static void __init omap_3430sdp_init(void)
>  		gpio_pendown = SDP3430_TS_GPIO_IRQ_SDPV2;
>  	else
>  		gpio_pendown = SDP3430_TS_GPIO_IRQ_SDPV1;
> -	omap_ads7846_init(1, gpio_pendown, 310, NULL);
> +	omap_ads7846_init(1, 0, gpio_pendown, 310, NULL);
>  	board_serial_init();
>  	omap_sdrc_init(hyb18m512160af6_sdrc_params, NULL);
>  	usb_musb_init(NULL);

This seems OK to me until we have device tree bindings for
this.

Regards,

Tony

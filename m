From: tomi.valkeinen@nokia.com (Tomi Valkeinen)
Date: Thu, 01 Jul 2010 10:05:54 +0300
Subject: [PATCH 13/16] omap: mux: Mux Apollon LCD power in board-apollon.c
In-Reply-To: <20100630120719.2637.65586.stgit@baageli.muru.com>
References: <20100630120226.2637.31198.stgit@baageli.muru.com>
	<20100630120719.2637.65586.stgit@baageli.muru.com>
Message-ID: <1277967954.2474.269.camel@tubuntu.research.nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-06-30 at 14:07 +0200, ext Tony Lindgren wrote:
> Use the new mux function for that.
> 
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/mach-omap2/board-apollon.c |    3 +++
>  drivers/video/omap/lcd_apollon.c    |    3 ---
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-omap2/board-apollon.c
> index b86a879..bc67026 100644
> --- a/arch/arm/mach-omap2/board-apollon.c
> +++ b/arch/arm/mach-omap2/board-apollon.c
> @@ -332,6 +332,9 @@ static void __init omap_apollon_init(void)
>  	/* REVISIT: where's the correct place */
>  	omap_cfg_reg(W19_24XX_SYS_NIRQ);
>  
> +	/* LCD PWR_EN */
> +	omap_mux_init_signal("mcbsp2_dr.gpio_11", OMAP_PULL_ENA | OMAP_PULL_UP);

LCD_PWR_EN sounds like output pin. However, I don't see lcd_apollon.c
nor board-apollon.c set the gpio.

I don't know what omap_cfg_reg(M21_242X_GPIO11) does, but if it does the
same thing as the line above, then does the apollon LCD work by luck?
OMAP pulling the line up, and by chance the pull is stronger than the
LCDs (possible) pull down, and thus the LCD is powered up...

 Tomi

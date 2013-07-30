From: archit@ti.com (Archit Taneja)
Date: Tue, 30 Jul 2013 11:18:45 +0530
Subject: [PATCH 09/21] ARM: OMAP: devkit8000: use new display drivers
In-Reply-To: <1374822504-28949-10-git-send-email-tomi.valkeinen@ti.com>
References: <1374822504-28949-1-git-send-email-tomi.valkeinen@ti.com>
 <1374822504-28949-10-git-send-email-tomi.valkeinen@ti.com>
Message-ID: <51F753BD.5040509@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Friday 26 July 2013 12:38 PM, Tomi Valkeinen wrote:
> Use new display drivers for devkit8000 board.
>
> The new OMAP display drivers were merged for 3.11, and we can now change
> the board files to use the new ones and phase out the old ones.
>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>   arch/arm/mach-omap2/board-devkit8000.c | 96 +++++++++++++++++++++++-----------
>   1 file changed, 65 insertions(+), 31 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
> index f1d91ba..cdc4fb9 100644
> --- a/arch/arm/mach-omap2/board-devkit8000.c
> +++ b/arch/arm/mach-omap2/board-devkit8000.c
> @@ -112,50 +112,81 @@ static struct regulator_consumer_supply devkit8000_vio_supply[] = {
>   	REGULATOR_SUPPLY("vcc", "spi2.0"),
>   };
>
> -static struct panel_generic_dpi_data lcd_panel = {
> -	.name			= "innolux_at070tn83",
> -	/* gpios filled in code */
> +static const struct display_timing devkit8000_lcd_videomode = {
> +	.pixelclock	= { 0, 40000000, 0 },

This is unrelated to the work being done here, but noticed that the 
pixel clock for this panel seems to be too high for the given timings. 
It puts the refresh rate around 90 Hz, which is odd.

Archit

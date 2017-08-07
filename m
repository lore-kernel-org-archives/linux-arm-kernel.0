From: khilman@baylibre.com (Kevin Hilman)
Date: Mon, 07 Aug 2017 14:06:20 -0700
Subject: [PATCH 03/14] mmc: meson-gx: clean up some constants
In-Reply-To: <20170804174353.16486-4-jbrunet@baylibre.com> (Jerome Brunet's
 message of "Fri, 4 Aug 2017 19:43:42 +0200")
References: <20170804174353.16486-1-jbrunet@baylibre.com>
 <20170804174353.16486-4-jbrunet@baylibre.com>
Message-ID: <7ha83bozoz.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> Remove useless clock rate defines. These should not be defined but

To be more precise, they're also unused, so maybe s/useless/unused/ ?

> equested from the clock framework.

s/equested/requested/

> Also correct typo on the DELAY register
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Otherwise,

Reviewed-by: Kevin Hilman <khilman@baylibre.com>

> ---
>  drivers/mmc/host/meson-gx-mmc.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index d480a8052a06..8a74a048db88 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -45,9 +45,7 @@
>  #define   CLK_DIV_MAX 63
>  #define   CLK_SRC_MASK GENMASK(7, 6)
>  #define   CLK_SRC_XTAL 0   /* external crystal */
> -#define   CLK_SRC_XTAL_RATE 24000000
>  #define   CLK_SRC_PLL 1    /* FCLK_DIV2 */
> -#define   CLK_SRC_PLL_RATE 1000000000
>  #define   CLK_CORE_PHASE_MASK GENMASK(9, 8)
>  #define   CLK_TX_PHASE_MASK GENMASK(11, 10)
>  #define   CLK_RX_PHASE_MASK GENMASK(13, 12)
> @@ -57,7 +55,7 @@
>  #define   CLK_PHASE_270 3
>  #define   CLK_ALWAYS_ON BIT(24)
>  
> -#define SD_EMMC_DElAY 0x4
> +#define SD_EMMC_DELAY 0x4
>  #define SD_EMMC_ADJUST 0x8
>  #define SD_EMMC_CALOUT 0x10
>  #define SD_EMMC_START 0x40

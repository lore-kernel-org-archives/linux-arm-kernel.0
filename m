From: mturquette@baylibre.com (Michael Turquette)
Date: Tue, 21 Mar 2017 16:28:02 -0700
Subject: [PATCH v3 1/3] clk: meson-gxbb: Add MALI clock IDS
In-Reply-To: <1489064027-18004-2-git-send-email-narmstrong@baylibre.com>
References: <1489064027-18004-1-git-send-email-narmstrong@baylibre.com>
 <1489064027-18004-2-git-send-email-narmstrong@baylibre.com>
Message-ID: <149013888277.54062.3821586656841121329@resonance>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Neil Armstrong (2017-03-09 04:53:45)
> Add missing MALI clock IDs and expose the muxes and gates in the dt-bindings.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Looks good to me.

Regards,
Mike

> ---
>  drivers/clk/meson/gxbb.h              | 9 ++++++++-
>  include/dt-bindings/clock/gxbb-clkc.h | 5 +++++
>  2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/meson/gxbb.h b/drivers/clk/meson/gxbb.h
> index 274f587..73efdc3 100644
> --- a/drivers/clk/meson/gxbb.h
> +++ b/drivers/clk/meson/gxbb.h
> @@ -268,8 +268,15 @@
>  /* CLKID_SAR_ADC_CLK */
>  /* CLKID_SAR_ADC_SEL */
>  #define CLKID_SAR_ADC_DIV        99
> +/* CLKID_MALI_0_SEL */
> +#define CLKID_MALI_0_DIV        101
> +/* CLKID_MALI_0        */
> +/* CLKID_MALI_1_SEL */
> +#define CLKID_MALI_1_DIV        104
> +/* CLKID_MALI_1        */
> +/* CLKID_MALI  */
>  
> -#define NR_CLKS                          100
> +#define NR_CLKS                          107
>  
>  /* include the CLKIDs that have been made part of the stable DT binding */
>  #include <dt-bindings/clock/gxbb-clkc.h>
> diff --git a/include/dt-bindings/clock/gxbb-clkc.h b/include/dt-bindings/clock/gxbb-clkc.h
> index f08f06d..ef7d6b7 100644
> --- a/include/dt-bindings/clock/gxbb-clkc.h
> +++ b/include/dt-bindings/clock/gxbb-clkc.h
> @@ -35,5 +35,10 @@
>  #define CLKID_SD_EMMC_C                96
>  #define CLKID_SAR_ADC_CLK      97
>  #define CLKID_SAR_ADC_SEL      98
> +#define CLKID_MALI_0_SEL       100
> +#define CLKID_MALI_0           102
> +#define CLKID_MALI_1_SEL       103
> +#define CLKID_MALI_1           105
> +#define CLKID_MALI             106
>  
>  #endif /* __GXBB_CLKC_H */
> -- 
> 1.9.1
> 

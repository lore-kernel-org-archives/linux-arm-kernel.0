From: tony@atomide.com (Tony Lindgren)
Date: Thu, 23 May 2013 11:46:37 -0700
Subject: [PATCH v2 5/5] ARM: dts: OMAP2+: use pinctrl constants
In-Reply-To: <1369323421-4180-6-git-send-email-florian.vaussard@epfl.ch>
References: <1369323421-4180-1-git-send-email-florian.vaussard@epfl.ch>
 <1369323421-4180-6-git-send-email-florian.vaussard@epfl.ch>
Message-ID: <20130523184636.GE13507@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Florian Vaussard <florian.vaussard@epfl.ch> [130523 08:42]:
> index f39b237..b3cc896 100644
> --- a/arch/arm/boot/dts/omap2.dtsi
> +++ b/arch/arm/boot/dts/omap2.dtsi
> @@ -9,6 +9,7 @@
>   */
>  
>  #include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/pinctrl/omap.h>
>  
>  #include "skeleton.dtsi"
>  
> diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
> index 434288f..2518e6a 100644
> --- a/arch/arm/boot/dts/omap3-beagle.dts
> +++ b/arch/arm/boot/dts/omap3-beagle.dts
> @@ -81,18 +81,18 @@
>  
>  	hsusbb2_pins: pinmux_hsusbb2_pins {
>  		pinctrl-single,pins = <
> -			0x5c0 0x3  /* USBB2_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_clk OUTPUT */
> -			0x5c2 0x3  /* USBB2_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_stp OUTPUT */
> -			0x5c4 0x10b  /* USBB2_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dir INPUT | PULLDOWN */
> -			0x5c6 0x10b  /* USBB2_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_nxt INPUT | PULLDOWN */
> -			0x5c8 0x10b  /* USBB2_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat0 INPUT | PULLDOWN */
> -			0x5cA 0x10b  /* USBB2_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat1 INPUT | PULLDOWN */
> -			0x1a4 0x10b  /* USBB2_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat2 INPUT | PULLDOWN */
> -			0x1a6 0x10b  /* USBB2_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat3 INPUT | PULLDOWN */
> -			0x1a8 0x10b  /* USBB2_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat4 INPUT | PULLDOWN */
> -			0x1aa 0x10b  /* USBB2_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat5 INPUT | PULLDOWN */
> -			0x1ac 0x10b  /* USBB2_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat6 INPUT | PULLDOWN */
> -			0x1ae 0x10b  /* USBB2_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat7 INPUT | PULLDOWN */
> +			0x5c0 (OMAP_PIN_OUTPUT | OMAP_MUX_MODE3)		/* USBB2_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_clk */
> +			0x5c2 (OMAP_PIN_OUTPUT | OMAP_MUX_MODE3)		/* USBB2_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_stp */
> +			0x5c4 (OMAP_PIN_INPUT_PULLDOWN | OMAP_MUX_MODE3)	/* USBB2_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dir */
> +			0x5c6 (OMAP_PIN_INPUT_PULLDOWN | OMAP_MUX_MODE3)	/* USBB2_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_nxt */
> +			0x5c8 (OMAP_PIN_INPUT_PULLDOWN | OMAP_MUX_MODE3)	/* USBB2_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat0 */
> +			0x5cA (OMAP_PIN_INPUT_PULLDOWN | OMAP_MUX_MODE3)	/* USBB2_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat1 */
> +			0x1a4 (OMAP_PIN_INPUT_PULLDOWN | OMAP_MUX_MODE3)	/* USBB2_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat2 */
> +			0x1a6 (OMAP_PIN_INPUT_PULLDOWN | OMAP_MUX_MODE3)	/* USBB2_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat3 */
> +			0x1a8 (OMAP_PIN_INPUT_PULLDOWN | OMAP_MUX_MODE3)	/* USBB2_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat4 */
> +			0x1aa (OMAP_PIN_INPUT_PULLDOWN | OMAP_MUX_MODE3)	/* USBB2_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat5 */
> +			0x1ac (OMAP_PIN_INPUT_PULLDOWN | OMAP_MUX_MODE3)	/* USBB2_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat6 */
> +			0x1ae (OMAP_PIN_INPUT_PULLDOWN | OMAP_MUX_MODE3)	/* USBB2_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat7 */
>  		>;
>  	};
>  };

Nice!

While at it, can you lowercase the USBB2_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_clk
naming to usbb2_ulpittl_clk.usbb1_ulpiphy_clk? You can also leave out _MUXMODE
from these for consistency.

I wonder if we can leave out the OMAP_ prefix from the mux mode defines
here and just assume PIN_OUTPUT etc would not conflict with other SoC's
naming?

Regards,

Tony

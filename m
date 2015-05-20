From: tony@atomide.com (Tony Lindgren)
Date: Wed, 20 May 2015 10:52:22 -0700
Subject: [PATCH] ARM: dts: omap3-gta04: Add hdqw1 support
In-Reply-To: <1430254467-29177-1-git-send-email-marek@goldelico.com>
References: <1430254467-29177-1-git-send-email-marek@goldelico.com>
Message-ID: <20150520175222.GD10274@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Marek Belisko <marek@goldelico.com> [150428 13:55]:
> Enable omap-hdq for battery fuel gauge access.
> 
> Signed-off-by: Marek Belisko <marek@goldelico.com>
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>

Applying into omap-for-v4.2/dt thanks.

Tony

> ---
>  arch/arm/boot/dts/omap3-gta04.dtsi | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
> index b9f6881..6ea1257 100644
> --- a/arch/arm/boot/dts/omap3-gta04.dtsi
> +++ b/arch/arm/boot/dts/omap3-gta04.dtsi
> @@ -200,6 +200,12 @@
>  			OMAP3_CORE1_IOPAD(0x210a, PIN_OUTPUT | MUX_MODE0)   /* dss_data23.dss_data23 */
>  		>;
>         };
> +
> +	hdq_pins: hdq_pins {
> +		pinctrl-single,pins = <
> +			OMAP3_CORE1_IOPAD(0x21c6, PIN_INPUT_PULLUP | MUX_MODE0) /* i2c3_sda.hdq */
> +		>;
> +	};
>  };
>  
>  &omap3_pmx_core2 {
> @@ -517,3 +523,8 @@
>  &mcbsp2 {
>  	status = "okay";
>  };
> +
> +&hdqw1w {
> +        pinctrl-names = "default";
> +        pinctrl-0 = <&hdq_pins>;
> +};
> -- 
> 1.9.1
> 

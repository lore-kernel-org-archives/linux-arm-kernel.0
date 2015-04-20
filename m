From: lee@kernel.org (Lee Jones)
Date: Mon, 20 Apr 2015 19:26:34 +0100
Subject: [PATCH 1/3] ARM: ux500: Move GPIO regulator for SD-card into
 board DTSs
In-Reply-To: <1429538553-17366-2-git-send-email-ulf.hansson@linaro.org>
References: <1429538553-17366-1-git-send-email-ulf.hansson@linaro.org>
 <1429538553-17366-2-git-send-email-ulf.hansson@linaro.org>
Message-ID: <20150420182634.GH3447@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 20 Apr 2015, Ulf Hansson wrote:

> The GPIO regulator for the SD-card isn't a ux500 SOC configuration, but
> instead it's specific to the board. Move the definition of it, into the
> board DTSs.

What makes you think that?

We normally place the common pieces (of which there are many in this
node) in the highest level DTSI file, then add the platform specific
ones in the DTS files.

> Fixes: c94a4ab7af3f ("ARM: ux500: Disable the MMCI gpio-regulator by default")
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  arch/arm/boot/dts/ste-dbx5x0.dtsi  | 17 -----------------
>  arch/arm/boot/dts/ste-href.dtsi    | 17 +++++++++++++++++
>  arch/arm/boot/dts/ste-snowball.dts | 15 +++++++++++++++
>  3 files changed, 32 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/ste-dbx5x0.dtsi b/arch/arm/boot/dts/ste-dbx5x0.dtsi
> index bfd3f1c..2201cd5 100644
> --- a/arch/arm/boot/dts/ste-dbx5x0.dtsi
> +++ b/arch/arm/boot/dts/ste-dbx5x0.dtsi
> @@ -1017,23 +1017,6 @@
>  			status = "disabled";
>  		};
>  
> -		vmmci: regulator-gpio {
> -			compatible = "regulator-gpio";
> -
> -			regulator-min-microvolt = <1800000>;
> -			regulator-max-microvolt = <2900000>;
> -			regulator-name = "mmci-reg";
> -			regulator-type = "voltage";
> -
> -			startup-delay-us = <100>;
> -			enable-active-high;
> -
> -			states = <1800000 0x1
> -				  2900000 0x0>;
> -
> -			status = "disabled";
> -		};
> -
>  		mcde at a0350000 {
>  			compatible = "stericsson,mcde";
>  			reg = <0xa0350000 0x1000>, /* MCDE */
> diff --git a/arch/arm/boot/dts/ste-href.dtsi b/arch/arm/boot/dts/ste-href.dtsi
> index bf8f0ed..8cf499a 100644
> --- a/arch/arm/boot/dts/ste-href.dtsi
> +++ b/arch/arm/boot/dts/ste-href.dtsi
> @@ -111,6 +111,23 @@
>  			pinctrl-1 = <&i2c3_sleep_mode>;
>  		};
>  
> +		vmmci: regulator-gpio {
> +			compatible = "regulator-gpio";
> +
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <2900000>;
> +			regulator-name = "mmci-reg";
> +			regulator-type = "voltage";
> +
> +			startup-delay-us = <100>;
> +			enable-active-high;
> +
> +			states = <1800000 0x1
> +				  2900000 0x0>;
> +
> +			status = "disabled";
> +		};
> +
>  		// External Micro SD slot
>  		sdi0_per1 at 80126000 {
>  			arm,primecell-periphid = <0x10480180>;
> diff --git a/arch/arm/boot/dts/ste-snowball.dts b/arch/arm/boot/dts/ste-snowball.dts
> index 206826a..65a7f63 100644
> --- a/arch/arm/boot/dts/ste-snowball.dts
> +++ b/arch/arm/boot/dts/ste-snowball.dts
> @@ -146,8 +146,23 @@
>  		};
>  
>  		vmmci: regulator-gpio {
> +			compatible = "regulator-gpio";
> +
>  			gpios = <&gpio7 4 0x4>;
>  			enable-gpio = <&gpio6 25 0x4>;
> +
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <2900000>;
> +			regulator-name = "mmci-reg";
> +			regulator-type = "voltage";
> +
> +			startup-delay-us = <100>;
> +			enable-active-high;
> +
> +			states = <1800000 0x1
> +				  2900000 0x0>;
> +
> +			status = "disabled";
>  		};
>  
>  		// External Micro SD slot

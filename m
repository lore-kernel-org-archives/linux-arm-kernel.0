From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 19 Feb 2014 15:13:51 +0800
Subject: [PATCH 3/4] ARM: dts: Enable SGTL5000 codec based audio driver
 node for VF610 TOWER.
In-Reply-To: <1392788323-6092-4-git-send-email-Li.Xiubo@freescale.com>
References: <1392788323-6092-1-git-send-email-Li.Xiubo@freescale.com>
 <1392788323-6092-4-git-send-email-Li.Xiubo@freescale.com>
Message-ID: <20140219071349.GH3010@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 19, 2014 at 01:38:42PM +0800, Xiubo Li wrote:
> This patch adds and enables SGTL5000 codec support.
> 
> Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
> ---
>  arch/arm/boot/dts/vf610-twr.dts | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/vf610-twr.dts b/arch/arm/boot/dts/vf610-twr.dts
> index 8217854..29790c9 100644
> --- a/arch/arm/boot/dts/vf610-twr.dts
> +++ b/arch/arm/boot/dts/vf610-twr.dts
> @@ -34,6 +34,17 @@
>  		};
>  	};
>  
> +	regulators {
> +		compatible = "simple-bus";

		#address-cells = <1>;
		#size-cells = <0>;

> +
> +		reg_3p3v: 3p3v {

		reg_3p3v: regulator at 0 {

> +			compatible = "regulator-fixed";

			reg = <0>;

Shawn

> +			regulator-name = "3P3V";
> +			regulator-min-microvolt = <3300000>;
> +			regulator-max-microvolt = <3300000>;
> +			regulator-always-on;
> +		};
> +	};
>  };
>  
>  &dspi0 {
> @@ -72,6 +83,14 @@
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_i2c0>;
>  	status = "okay";
> +
> +	codec: sgtl5000 at 0a {
> +	       compatible = "fsl,sgtl5000";
> +	       reg = <0x0a>;
> +	       VDDA-supply = <&reg_3p3v>;
> +	       VDDIO-supply = <&reg_3p3v>;
> +	       clocks = <&clks VF610_CLK_SAI2>;
> +       };
>  };
>  
>  &iomuxc {
> -- 
> 1.8.4
> 
> 

From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 27 Apr 2015 16:51:57 +0800
Subject: [PATCH] ARM: dts: imx6qdl-hummingboard: Add PCIe support
In-Reply-To: <1428540113-24616-1-git-send-email-festevam@gmail.com>
References: <1428540113-24616-1-git-send-email-festevam@gmail.com>
Message-ID: <20150427085156.GG9231@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 08, 2015 at 09:41:53PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Add PCIe support. Based on a patch from Rabeeh Khoury from the solid-run
> tree.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Russell,

Are you fine with this patch?

Shawn

> ---
>  arch/arm/boot/dts/imx6qdl-hummingboard.dtsi | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi b/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
> index 151a3db..ccdfcfa 100644
> --- a/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
> @@ -192,6 +192,12 @@
>  			>;
>  		};
>  
> +		pinctrl_hummingboard_pcie_reset: hummingboard-pcie-reset {
> +			fsl,pins = <
> +				MX6QDL_PAD_EIM_DA4__GPIO3_IO04 0x1b0b1
> +			>;
> +		};
> +
>  		pinctrl_hummingboard_pwm1: pwm1grp {
>  			fsl,pins = <MX6QDL_PAD_DISP0_DAT8__PWM1_OUT 0x1b0b1>;
>  		};
> @@ -245,6 +251,13 @@
>  	};
>  };
>  
> +&pcie {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_hummingboard_pcie_reset>;
> +	reset-gpio = <&gpio3 4 0>;
> +	status = "okay";
> +};
> +
>  &pwm1 {
>  	 pinctrl-names = "default";
>  	 pinctrl-0 = <&pinctrl_hummingboard_pwm1>;
> -- 
> 1.9.1
> 

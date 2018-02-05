From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 5 Feb 2018 14:15:50 +0800
Subject: [PATCH] ARM: dts: hummingboard: enable pwm3
In-Reply-To: <ca77a0ea31bfc802d0a3192aef453c9e40e6040d.1516631485.git.baruch@tkos.co.il>
References: <ca77a0ea31bfc802d0a3192aef453c9e40e6040d.1516631485.git.baruch@tkos.co.il>
Message-ID: <20180205061549.GF31354@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 22, 2018 at 04:31:25PM +0200, Baruch Siach wrote:
> pwm3 controls the backlight of the LVDS display.
> 
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>

Russell, are you okay with the patch?

Shawn

> ---
>  arch/arm/boot/dts/imx6qdl-hummingboard.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi b/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
> index 92583238ca4a..6834f4ce0c22 100644
> --- a/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
> @@ -219,6 +219,12 @@
>  			fsl,pins = <MX6QDL_PAD_DISP0_DAT8__PWM1_OUT 0x1b0b1>;
>  		};
>  
> +		pinctrl_hummingboard_pwm3: pwm3grp {
> +			fsl,pins = <
> +				MX6QDL_PAD_SD4_DAT1__PWM3_OUT 0x1b0b1
> +			>;
> +		};
> +
>  		pinctrl_hummingboard_sgtl5000: hummingboard-sgtl5000 {
>  			fsl,pins = <
>  				MX6QDL_PAD_DISP0_DAT19__AUD5_RXD 0x130b0
> @@ -291,6 +297,12 @@
>  	 status = "okay";
>  };
>  
> +&pwm3 {
> +	 pinctrl-names = "default";
> +	 pinctrl-0 = <&pinctrl_hummingboard_pwm3>;
> +	 status = "okay";
> +};
> +
>  &spdif {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_hummingboard_spdif>;
> -- 
> 2.15.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 30 Aug 2016 09:33:41 +0200
Subject: [PATCH 3/4] ARM: dts: add fimc support in exynos4412 TOPEET iTop
 Elite board
In-Reply-To: <1472383269-3126-4-git-send-email-ayaka@soulik.info>
References: <CAL_JsqKY=VEZ+U11kY+XbMWuXhaFDr6GpnR3AXKd1U=9_=8fgA@mail.gmail.com>
 <1472383269-3126-1-git-send-email-ayaka@soulik.info>
 <1472383269-3126-4-git-send-email-ayaka@soulik.info>
Message-ID: <f90ffaf4-dc95-9c32-1f4d-771f96424783@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/28/2016 01:21 PM, Randy Li wrote:
> The is not used for camera, I enabled it just for a colorspace
> convertor.
> 
> Signed-off-by: Randy Li <ayaka@soulik.info>
> ---
>  arch/arm/boot/dts/exynos4412-itop-elite.dts | 16 ++++++++++++++++

This should be squashed with patch #2.

BTW, please add also vendor prefix
(Documentation/devicetree/bindings/vendor-prefixes.txt).

Best regards,
Krzysztof

>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/exynos4412-itop-elite.dts b/arch/arm/boot/dts/exynos4412-itop-elite.dts
> index 5688589..2d11b9a 100644
> --- a/arch/arm/boot/dts/exynos4412-itop-elite.dts
> +++ b/arch/arm/boot/dts/exynos4412-itop-elite.dts
> @@ -82,6 +82,14 @@
>  		pinctrl-0 = <&pwm0_out>;
>  		pinctrl-names = "default";
>  	};
> +
> +	camera: camera {
> +		pinctrl-0 = <&cam_port_a_clk_active>;
> +		pinctrl-names = "default";
> +		status = "okay";
> +		assigned-clocks = <&clock CLK_MOUT_CAM0>;
> +		assigned-clock-parents = <&clock CLK_XUSBXTI>;
> +	};
>  };
>  
>  &pinctrl_1 {
> @@ -146,3 +154,11 @@
>  	vdd-supply = <&ldo3_reg>;
>  	status = "okay";
>  };
> +
> +&fimc_0 {
> +	status = "okay";
> +	assigned-clocks = <&clock CLK_MOUT_FIMC0>,
> +			<&clock CLK_SCLK_FIMC0>;
> +	assigned-clock-parents = <&clock CLK_MOUT_MPLL_USER_T>;
> +	assigned-clock-rates = <0>, <176000000>;
> +};
> 

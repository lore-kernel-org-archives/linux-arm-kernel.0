From: tushar.behera@linaro.org (Tushar Behera)
Date: Tue, 02 Jul 2013 10:51:36 +0530
Subject: [PATCH 3/3] ARM: dts: Add WM1811A audio CODEC to Arndale bindings
In-Reply-To: <1372714599-17588-3-git-send-email-broonie@kernel.org>
References: <1372714599-17588-1-git-send-email-broonie@kernel.org>
 <1372714599-17588-3-git-send-email-broonie@kernel.org>
Message-ID: <51D26360.2080708@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/02/2013 03:06 AM, Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
> 
> The default audio module for the Arndale has a WM811A on it. Add this to

typo: WM1811A

Arndale board also comes with two other audio codec boards - ALC5631Q
and AK4678. Different audio codec boards came with different shipments.

> the device tree bindings.
> 
> Signed-off-by: Mark Brown <broonie@linaro.org>
> ---
>  arch/arm/boot/dts/exynos5250-arndale.dts | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/exynos5250-arndale.dts b/arch/arm/boot/dts/exynos5250-arndale.dts
> index 482f275..75c3065 100644
> --- a/arch/arm/boot/dts/exynos5250-arndale.dts
> +++ b/arch/arm/boot/dts/exynos5250-arndale.dts
> @@ -325,7 +325,22 @@
>  	};
>  
>  	i2c at 12C90000 {
> -		status = "disabled";
> +		wm1811a at 11 {
> +			compatible = "wlf,wm1811";
> +			reg = <0x1a>;
> +
> +			AVDD2-supply = <&main_dc_reg>;
> +			CPVDD-supply = <&main_dc_reg>;
> +			DBVDD1-supply = <&main_dc_reg>;
> +			DBVDD2-supply = <&main_dc_reg>;
> +			DBVDD3-supply = <&main_dc_reg>;
> +			LDO1VDD-supply = <&main_dc_reg>;
> +			SPKVDD1-supply = <&main_dc_reg>;
> +			SPKVDD2-supply = <&main_dc_reg>;
> +
> +			wlf,ldo1ena = <&gpb0 0 0>;
> +			wlf,ldo2ena = <&gpb0 1 0>;
> +		};
>  	};
>  
>  	i2c at 12CA0000 {
> 


-- 
Tushar Behera

From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 07 Aug 2013 17:14:10 +0200
Subject: [PATCH V3 4/7] ARM: dts: exynos5250: move common i2s properties to
 exynos5 dtsi
In-Reply-To: <1375866616-5541-5-git-send-email-padma.v@samsung.com>
References: <1375866616-5541-1-git-send-email-padma.v@samsung.com>
 <1375866616-5541-5-git-send-email-padma.v@samsung.com>
Message-ID: <1524793.q6RAF3Nan6@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 07 of August 2013 14:40:13 Padmavathi Venna wrote:
> I2S nodes shares some properties across exynos5 SoCs (exynos5250
> and exyno5420). Common code is moved to exynos5.dtsi which is
> included in exyno5250 and exynos5420 SoC files.

Shouldn't this patch be ordered before patch 1/7, which already uses the 
i2s1 and i2s2 nodes inherited from exynos5.dtsi, even though they get moved 
to it later in this series.

Best regards,
Tomasz

> Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5.dtsi    |   21 +++++++++++++++++++++
>  arch/arm/boot/dts/exynos5250.dtsi |   12 ------------
>  2 files changed, 21 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/exynos5.dtsi
> b/arch/arm/boot/dts/exynos5.dtsi index ec384c9..c37b57d 100644
> --- a/arch/arm/boot/dts/exynos5.dtsi
> +++ b/arch/arm/boot/dts/exynos5.dtsi
> @@ -191,4 +191,25 @@
>  		#size-cells = <0>;
>  		status = "disabled";
>  	};
> +
> +	i2s0: i2s at 03830000 {
> +		reg = <0x03830000 0x100>;
> +		samsung,idma-addr = <0x03000000>;
> +	};
> +
> +	i2s1: i2s at 12D60000 {
> +		compatible = "samsung,s3c6410-i2s";
> +		reg = <0x12D60000 0x100>;
> +		dmas = <&pdma1 12
> +			&pdma1 11>;
> +		dma-names = "tx", "rx";
> +	};
> +
> +	i2s2: i2s at 12D70000 {
> +		compatible = "samsung,s3c6410-i2s";
> +		reg = <0x12D70000 0x100>;
> +		dmas = <&pdma0 12
> +			&pdma0 11>;
> +		dma-names = "tx", "rx";
> +	};
>  };
> diff --git a/arch/arm/boot/dts/exynos5250.dtsi
> b/arch/arm/boot/dts/exynos5250.dtsi index 5b36121..3873ff7 100644
> --- a/arch/arm/boot/dts/exynos5250.dtsi
> +++ b/arch/arm/boot/dts/exynos5250.dtsi
> @@ -394,7 +394,6 @@
> 
>  	i2s0: i2s at 03830000 {
>  		compatible = "samsung,s5pv210-i2s";
> -		reg = <0x03830000 0x100>;
>  		dmas = <&pdma0 10
>  			&pdma0 9
>  			&pdma0 8>;
> @@ -403,17 +402,11 @@
>  			<&clock_audss EXYNOS_I2S_BUS>,
>  			<&clock_audss EXYNOS_SCLK_I2S>;
>  		clock-names = "iis", "i2s_opclk0", "i2s_opclk1";
> -		samsung,idma-addr = <0x03000000>;
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&i2s0_bus>;
>  	};
> 
>  	i2s1: i2s at 12D60000 {
> -		compatible = "samsung,s3c6410-i2s";
> -		reg = <0x12D60000 0x100>;
> -		dmas = <&pdma1 12
> -			&pdma1 11>;
> -		dma-names = "tx", "rx";
>  		clocks = <&clock 307>, <&clock 157>;
>  		clock-names = "iis", "i2s_opclk0";
>  		pinctrl-names = "default";
> @@ -421,11 +414,6 @@
>  	};
> 
>  	i2s2: i2s at 12D70000 {
> -		compatible = "samsung,s3c6410-i2s";
> -		reg = <0x12D70000 0x100>;
> -		dmas = <&pdma0 12
> -			&pdma0 11>;
> -		dma-names = "tx", "rx";
>  		clocks = <&clock 308>, <&clock 158>;
>  		clock-names = "iis", "i2s_opclk0";
>  		pinctrl-names = "default";

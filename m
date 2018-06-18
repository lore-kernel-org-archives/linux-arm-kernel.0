From: joe@perches.com (Joe Perches)
Date: Mon, 18 Jun 2018 10:57:56 -0700
Subject: [PATCH 1/2] arm64: dts: exynos: Remove leading 0x from unit
 addresses in Exynos5433
In-Reply-To: <20180618174216.24801-1-krzk@kernel.org>
References: <20180618174216.24801-1-krzk@kernel.org>
Message-ID: <6755acb72649a712bd16cee4cab92f1aa63b70b9.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2018-06-18 at 19:42 +0200, Krzysztof Kozlowski wrote:
> Remove leading 0x from recently introduced unit addresses to fix DTC
> warnings:
> 
>     Warning (unit_address_format): /soc/sysmmu at 0x15040000: unit name should not have leading "0x"
[]
> diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
[]
> @@ -1171,7 +1171,7 @@
>  			power-domains = <&pd_gscl>;
>  		};
>  
> -		sysmmu_scaler_0: sysmmu at 0x15040000 {
> +		sysmmu_scaler_0: sysmmu at 15040000 {
>  			compatible = "samsung,exynos-sysmmu";
>  			reg = <0x15040000 0x1000>;
>  			interrupts = <GIC_SPI 404 IRQ_TYPE_LEVEL_HIGH>;
> @@ -1182,7 +1182,7 @@
>  			power-domains = <&pd_mscl>;
>  		};
>  
> -		sysmmu_scaler_1: sysmmu at 0x15050000 {
> +		sysmmu_scaler_1: sysmmu at 15050000 {
>  			compatible = "samsung,exynos-sysmmu";
>  			reg = <0x15050000 0x1000>;
>  			interrupts = <GIC_SPI 406 IRQ_TYPE_LEVEL_HIGH>;

Presumably these 3 other entries too?

$ git grep -P "\b\w+:\s+\w+ at 0x" -- "*.dt*"
arch/arc/boot/dts/abilis_tb10x.dtsi:            spi0: spi at 0xFE010000 {
arch/arc/boot/dts/abilis_tb10x.dtsi:            spi1: spi at 0xFE011000 {
arch/arc/boot/dts/vdk_axs10x_mb.dtsi:   uio_ev: uio at 0xD0000000 {
arch/arm64/boot/dts/exynos/exynos5433.dtsi:             sysmmu_scaler_0: sysmmu at 0x15040000 {
arch/arm64/boot/dts/exynos/exynos5433.dtsi:             sysmmu_scaler_1: sysmmu at 0x15050000 {

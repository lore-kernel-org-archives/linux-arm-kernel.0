From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 24 Jun 2013 20:17:02 +0200
Subject: [PATCH v2 4/8] ARM: dts: Use generic DMA bindings for Exynos4 SPI
 devices
In-Reply-To: <1372097151-18122-5-git-send-email-s.nawrocki@samsung.com>
References: <1372097151-18122-1-git-send-email-s.nawrocki@samsung.com>
 <1372097151-18122-5-git-send-email-s.nawrocki@samsung.com>
Message-ID: <51C88D1E.90203@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/24/2013 08:05 PM, Sylwester Nawrocki wrote:
> The Exynos4 SPI controller uses the PL330 DMA controller which has
> migrated to the generic DMA bindings since commit b5be04d35dbb2e00
> "spi: s3c64xx: Modify SPI driver to use generic DMA DT support".
> Use the generic bindings to specify the corresponding DMA to make
> the SPI usable again on Exynos4x12 SOCs.

Huh, I've forgotten to correct this commit description, since it was
originally written with different related commit in mind.
Kgene, unless I post v3, could you amend the above with:

The Exynos4 SPI controller has migrated to the generic DMA bindings
since commit b5be04d35dbb2e00
"spi: s3c64xx: Modify SPI driver to use generic DMA DT support".
Use the generic bindings to specify the corresponding DMA to make
the SPI usable again on Exynos4x12 SoCs.

? I guess this is going to be for 3.12 only now ?

Thanks,
Sylwester

> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/boot/dts/exynos4.dtsi |   12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
> index 3f94fe8..bce2254 100644
> --- a/arch/arm/boot/dts/exynos4.dtsi
> +++ b/arch/arm/boot/dts/exynos4.dtsi
> @@ -297,8 +297,8 @@
>  		compatible = "samsung,exynos4210-spi";
>  		reg = <0x13920000 0x100>;
>  		interrupts = <0 66 0>;
> -		tx-dma-channel = <&pdma0 7>; /* preliminary */
> -		rx-dma-channel = <&pdma0 6>; /* preliminary */
> +		dmas = <&pdma0 7>, <&pdma0 6>;
> +		dma-names = "tx", "rx";
>  		#address-cells = <1>;
>  		#size-cells = <0>;
>  		clocks = <&clock 327>, <&clock 159>;
> @@ -312,8 +312,8 @@
>  		compatible = "samsung,exynos4210-spi";
>  		reg = <0x13930000 0x100>;
>  		interrupts = <0 67 0>;
> -		tx-dma-channel = <&pdma1 7>; /* preliminary */
> -		rx-dma-channel = <&pdma1 6>; /* preliminary */
> +		dmas = <&pdma1 7>, <&pdma1 6>;
> +		dma-names = "tx", "rx";
>  		#address-cells = <1>;
>  		#size-cells = <0>;
>  		clocks = <&clock 328>, <&clock 160>;
> @@ -327,8 +327,8 @@
>  		compatible = "samsung,exynos4210-spi";
>  		reg = <0x13940000 0x100>;
>  		interrupts = <0 68 0>;
> -		tx-dma-channel = <&pdma0 9>; /* preliminary */
> -		rx-dma-channel = <&pdma0 8>; /* preliminary */
> +		dmas = <&pdma0 9>, <&pdma0 8>;
> +		dma-names = "tx", "rx";
>  		#address-cells = <1>;
>  		#size-cells = <0>;
>  		clocks = <&clock 329>, <&clock 161>;

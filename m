From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 04 Nov 2015 17:12:40 +0900
Subject: [PATCH v5 2/4] ARM: dts: Add SROMc to Exynos 5410
In-Reply-To: <69aa5165bf2e696c0a684a9ba49cd4d5acb25046.1446542020.git.p.fedin@samsung.com>
References: <cover.1446542020.git.p.fedin@samsung.com>
 <69aa5165bf2e696c0a684a9ba49cd4d5acb25046.1446542020.git.p.fedin@samsung.com>
Message-ID: <5639BDF8.1080107@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03.11.2015 18:16, Pavel Fedin wrote:
> This machine uses own SoC device tree file, add missing part.
> We insert the complete description, with ranges, because we are going to
> connect devices to it. Values in ranges are SoC-specific, so they go here
> in order not to duplicate them for every machine.
> 
> Signed-off-by: Pavel Fedin <p.fedin@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5410.dtsi | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/exynos5410.dtsi b/arch/arm/boot/dts/exynos5410.dtsi
> index 4603356..9cfb814 100644
> --- a/arch/arm/boot/dts/exynos5410.dtsi
> +++ b/arch/arm/boot/dts/exynos5410.dtsi
> @@ -101,6 +101,17 @@
>  			reg = <0x10000000 0x100>;
>  		};
>  
> +		sromc: sromc at 12250000 {
> +			compatible = "samsung,exynos-srom";
> +			reg = <0x12250000 0x14>;
> +			#address-cells = <2>;
> +			#size-cells = <1>;
> +			ranges = <0 0 0x04000000 0x20000
> +				  1 0 0x05000000 0x20000
> +				  2 0 0x06000000 0x20000
> +				  3 0 0x07000000 0x20000>;

Following my comments for bindings documentation - I think it is better
to add the address-cells, size-cells and ranges in 4th patch.

Because actually in this patch you are adding just basic support for
SROM controller: for saving and restoring registers. It could be merged
even without the rest of patchset.

Best regards,
Krzysztof

> +		};
> +
>  		pmu_system_controller: system-controller at 10040000 {
>  			compatible = "samsung,exynos5410-pmu", "syscon";
>  			reg = <0x10040000 0x5000>;
> 

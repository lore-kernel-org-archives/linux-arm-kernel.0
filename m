From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 28 Jul 2015 14:53:14 +0900
Subject: [RFC PATCH 3/3] ARM: dts: add MCT property use-cp15-phys-counter
 for exynos5422-odroidxu3
In-Reply-To: <1438032528.17734.49.camel@gmail.com>
References: <1438032528.17734.49.camel@gmail.com>
Message-ID: <55B718CA.3050103@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28.07.2015 06:28, Alexey Klimov wrote:
> Speedup MCT operation on odroid-xu3 dev board by using
> coprocessor 64-bit counter instead of reading same counter
> located in mmio region.
> 
> Tested on Odroid-xu3.
> 
> Signed-off-by: Alexey Klimov <klimov.linux@gmail.com>
> ---
>  arch/arm/boot/dts/exynos5422-odroidxu3.dts | 4 ++++

Please do this in Odroid XU3 common DTSI:
arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi

>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3.dts b/arch/arm/boot/dts/exynos5422-odroidxu3.dts
> index 78e6a50..b7f6c8f 100644
> --- a/arch/arm/boot/dts/exynos5422-odroidxu3.dts
> +++ b/arch/arm/boot/dts/exynos5422-odroidxu3.dts
> @@ -18,6 +18,10 @@
>  	compatible = "hardkernel,odroid-xu3", "samsung,exynos5800", "samsung,exynos5";
>  };
>  
> +&mct {
> +	use-cp15-phys-counter;
> +};
> +

Put the node in alphabetical position.

Best regards,
Krzysztof

>  &i2c_0 {
>  	status = "okay";
>  
> 

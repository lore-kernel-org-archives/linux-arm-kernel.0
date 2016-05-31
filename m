From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Tue, 31 May 2016 15:01:24 -0400
Subject: [PATCH 3/6] ARM: dts: exynos: Interrupt for USB DWC3-1 differs
 between Exynos5420 and 5410
In-Reply-To: <1464719945-3417-3-git-send-email-krzk@kernel.org>
References: <1464719945-3417-1-git-send-email-krzk@kernel.org>
 <1464719945-3417-3-git-send-email-krzk@kernel.org>
Message-ID: <fca224e1-af8c-5540-d47a-9f05e494b2c4@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 05/31/2016 02:39 PM, Krzysztof Kozlowski wrote:
> On Exynos5410 the SPI interrupt for second USB DWC3 (called DRD: Dual
> Role Device) is different - 200 instead of 73.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  arch/arm/boot/dts/exynos5410.dtsi | 4 ++++
>  arch/arm/boot/dts/exynos5420.dtsi | 4 ++++
>  arch/arm/boot/dts/exynos54xx.dtsi | 1 -
>  3 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/exynos5410.dtsi b/arch/arm/boot/dts/exynos5410.dtsi
> index a937d9bdad90..994d16a44fe4 100644
> --- a/arch/arm/boot/dts/exynos5410.dtsi
> +++ b/arch/arm/boot/dts/exynos5410.dtsi
> @@ -267,6 +267,10 @@
>  	clock-names = "usbdrd30";
>  };
>  
> +&usbdrd_dwc3_1 {
> +	interrupts = <0 200 0>;

Please use GIC_SPI from <dt-bindings/interrupt-controller/arm-gic.h> instead 0.

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America

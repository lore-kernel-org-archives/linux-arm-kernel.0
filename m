From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Fri, 30 May 2014 20:49:25 +0900
Subject: [PATCH] ARM: dts: Add pmu sysreg node to Exynos3250
In-Reply-To: <1401085776-14212-1-git-send-email-cw00.choi@samsung.com>
References: <1401085776-14212-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <53887045.9010203@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ping,

Could you review this patch?

Thanks,
Chanwoo Choi

On 05/26/2014 03:29 PM, Chanwoo Choi wrote:
> This patch add pmusysreg node for Exynos3250 to access PMU (Power Management Unit)
> register in a centralized way using syscon driver.
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  Documentation/devicetree/bindings/arm/samsung/pmu.txt | 1 +
>  arch/arm/boot/dts/exynos3250.dtsi                     | 5 +++++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/samsung/pmu.txt b/Documentation/devicetree/bindings/arm/samsung/pmu.txt
> index b562634..2a4ab04 100644
> --- a/Documentation/devicetree/bindings/arm/samsung/pmu.txt
> +++ b/Documentation/devicetree/bindings/arm/samsung/pmu.txt
> @@ -2,6 +2,7 @@ SAMSUNG Exynos SoC series PMU Registers
>  
>  Properties:
>   - compatible : should contain two values. First value must be one from following list:
> +		   - "samsung,exynos3250-pmu" - for Exynos3250 SoC,
>  		   - "samsung,exynos4210-pmu" - for Exynos4210 SoC,
>  		   - "samsung,exynos4212-pmu" - for Exynos4212 SoC,
>  		   - "samsung,exynos4412-pmu" - for Exynos4412 SoC,
> diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
> index ca28eac..3e678fa 100644
> --- a/arch/arm/boot/dts/exynos3250.dtsi
> +++ b/arch/arm/boot/dts/exynos3250.dtsi
> @@ -125,6 +125,11 @@
>  			reg = <0x10010000 0x400>;
>  		};
>  
> +		pmu_system_controller: system-controller at 10020000 {
> +			compatible = "samsung,exynos3250-pmu", "syscon";
> +			reg = <0x10020000 0x4000>;
> +		};
> +
>  		pd_cam: cam-power-domain at 10023C00 {
>  			compatible = "samsung,exynos4210-pd";
>  			reg = <0x10023C00 0x20>;
> 

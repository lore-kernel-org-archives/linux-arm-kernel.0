From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Fri, 23 Feb 2018 09:30:06 +0900
Subject: [PATCH 1/2] ARM: dts: exynos: Fix address of PPMU ACP on
 Exynos4210
In-Reply-To: <20180222191111.23747-1-krzk@kernel.org>
References: <CGME20180222191146epcas2p1e0fc10e3f8b278f0c3671d32e2d76350@epcas2p1.samsung.com>
 <20180222191111.23747-1-krzk@kernel.org>
Message-ID: <5A8F608E.4030509@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018? 02? 23? 04:11, Krzysztof Kozlowski wrote:
> Typo in unit address of PPMU ACP caused DTC warnings:
> 
>     arch/arm/boot/dts/exynos4412-odroidu3.dtb:
>         Warning (simple_bus_reg): Node /soc/ppmu_acp at 10ae0000 simple-bus unit address format error, expected "106e0000"
> 
> PPMU ACP (under 0x10ae0000 address) is present only in Exynos4210 so
> move this node to exynos4210.dtsi with fixing the reg address to proper
> one.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  arch/arm/boot/dts/exynos4.dtsi    | 6 ------
>  arch/arm/boot/dts/exynos4210.dtsi | 6 ++++++
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
> index 967cd02401c5..909a9f2bf5be 100644
> --- a/arch/arm/boot/dts/exynos4.dtsi
> +++ b/arch/arm/boot/dts/exynos4.dtsi
> @@ -821,12 +821,6 @@
>  			status = "disabled";
>  		};
>  
> -		ppmu_acp: ppmu_acp at 10ae0000 {
> -			compatible = "samsung,exynos-ppmu";
> -			reg = <0x106e0000 0x2000>;
> -			status = "disabled";
> -		};
> -
>  		ppmu_rightbus: ppmu_rightbus at 112a0000 {
>  			compatible = "samsung,exynos-ppmu";
>  			reg = <0x112a0000 0x2000>;
> diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
> index 853604d91158..88fb47cef9a8 100644
> --- a/arch/arm/boot/dts/exynos4210.dtsi
> +++ b/arch/arm/boot/dts/exynos4210.dtsi
> @@ -162,6 +162,12 @@
>  			iommus = <&sysmmu_g2d>;
>  		};
>  
> +		ppmu_acp: ppmu_acp at 10ae0000 {
> +			compatible = "samsung,exynos-ppmu";
> +			reg = <0x10ae0000 0x2000>;
> +			status = "disabled";
> +		};
> +
>  		ppmu_lcd1: ppmu_lcd1 at 12240000 {
>  			compatible = "samsung,exynos-ppmu";
>  			reg = <0x12240000 0x2000>;
> 

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

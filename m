From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Wed, 17 Oct 2018 14:01:57 +0900
Subject: [PATCH v2 5/6] arm64: dts: exynos: Move arch-timer node to
 right place
In-Reply-To: <20181015123112.9379-6-m.szyprowski@samsung.com>
References: <20181015123112.9379-1-m.szyprowski@samsung.com>
 <CGME20181015123136eucas1p292c0d6662da5e6694e9f6773282ea017@eucas1p2.samsung.com>
 <20181015123112.9379-6-m.szyprowski@samsung.com>
Message-ID: <5BC6C245.7040407@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

On 2018? 10? 15? 21:31, Marek Szyprowski wrote:
> Move ARM architected timer device-tree node to the beginning of 'soc'
> node, to group it together with other ARM CPU core devices (like PMU).
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  arch/arm64/boot/dts/exynos/exynos5433.dtsi | 23 +++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
> index 2131f12364cb..fa20eb3495b3 100644
> --- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
> +++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
> @@ -255,6 +255,18 @@
>  			interrupt-affinity = <&cpu4>, <&cpu5>, <&cpu6>, <&cpu7>;
>  		};
>  
> +		timer: timer {
> +			compatible = "arm,armv8-timer";
> +			interrupts = <GIC_PPI 13
> +					(GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_HIGH)>,
> +				<GIC_PPI 14
> +					(GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_HIGH)>,
> +				<GIC_PPI 11
> +					(GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_HIGH)>,
> +				<GIC_PPI 10
> +					(GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_HIGH)>;
> +		};
> +
>  		chipid at 10000000 {
>  			compatible = "samsung,exynos4210-chipid";
>  			reg = <0x10000000 0x100>;
> @@ -1750,17 +1762,6 @@
>  		};
>  	};
>  
> -	timer: timer {
> -		compatible = "arm,armv8-timer";
> -		interrupts = <GIC_PPI 13
> -				(GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_HIGH)>,
> -			<GIC_PPI 14
> -				(GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_HIGH)>,
> -			<GIC_PPI 11
> -				(GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_HIGH)>,
> -			<GIC_PPI 10
> -				(GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_HIGH)>;
> -	};
>  };
>  
>  #include "exynos5433-bus.dtsi"
> 

I tested it on Exynos5433-based TM2 board. It is well working.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Tested-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

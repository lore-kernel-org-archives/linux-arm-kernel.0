From: tushar.behera@linaro.org (Tushar Behera)
Date: Tue, 29 Apr 2014 11:37:45 +0530
Subject: [PATCH-RESEND] ARM: dts: Add arm-pmu node for exynos4412
In-Reply-To: <1376044914-1759-1-git-send-email-chanho61.park@samsung.com>
References: <1376044914-1759-1-git-send-email-chanho61.park@samsung.com>
Message-ID: <535F41B1.70404@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/09/2013 04:11 PM, Chanho Park wrote:
> The Exynos4412 has 4 cpus and each has a performance counter.
> Thus, we should define 4 interrupts which are combined by irq-combiner for arm
> pmu.
> 
> Signed-off-by: Chanho Park <chanho61.park@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/boot/dts/exynos4412.dtsi |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
> index e743e67..cfad655 100644
> --- a/arch/arm/boot/dts/exynos4412.dtsi
> +++ b/arch/arm/boot/dts/exynos4412.dtsi
> @@ -35,6 +35,12 @@
>  			     <0 107 0>, <0 108 0>, <0 48 0>, <0 42 0>;
>  	};
>  
> +	pmu {
> +		compatible = "arm,cortex-a9-pmu";
> +		interrupt-parent = <&combiner>;
> +		interrupts = <2 2>, <3 2>, <18 2>, <19 2>;
> +	};
> +
>  	mct at 10050000 {
>  		compatible = "samsung,exynos4412-mct";
>  		reg = <0x10050000 0x800>;
> 

Tested on Exynos4412 based Origen-Quad board. You would required to
rebase it on latest code though.

Tested-by: Tushar Behera <tushar.behera@linaro.org>

-- 
Tushar Behera

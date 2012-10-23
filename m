From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 23 Oct 2012 23:01:42 +0900
Subject: [PATCH v4 4/5] ARM: EXYNOS: Add arm-pmu DT binding for exynos5250
In-Reply-To: <1349662630-11607-5-git-send-email-chanho61.park@samsung.com>
References: <1349662630-11607-1-git-send-email-chanho61.park@samsung.com>
 <1349662630-11607-5-git-send-email-chanho61.park@samsung.com>
Message-ID: <020e01cdb126$ee4b0560$cae11020$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Chanho Park wrote:
> 
> This patch enables arm-pmu to bind device tree for exynos5250. The
> exynos5250
> has two pmus which have combiner irq type.
> 
> Reviewed-by: Thomas Abraham <thomas.abraham@linaro.org>
> Signed-off-by: Chanho Park <chanho61.park@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5250.dtsi |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/exynos5250.dtsi
> b/arch/arm/boot/dts/exynos5250.dtsi
> index dddfd6e..fab3eae 100644
> --- a/arch/arm/boot/dts/exynos5250.dtsi
> +++ b/arch/arm/boot/dts/exynos5250.dtsi
> @@ -56,6 +56,12 @@
>  			     <0 28 0>, <0 29 0>, <0 30 0>, <0 31 0>;
>  	};
> 
> +	pmu {
> +		compatible = "arm,cortex-a15-pmu";
> +		interrupt-parent = <&combiner>;
> +		interrupts = <1 2>, <22 4>;
> +	};
> +
>  	watchdog {
>  		compatible = "samsung,s3c2410-wdt";
>  		reg = <0x101D0000 0x100>;
> --
> 1.7.9.5

OK, applied.
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

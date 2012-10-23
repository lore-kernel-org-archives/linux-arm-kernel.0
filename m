From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 23 Oct 2012 23:02:18 +0900
Subject: [PATCH v4 5/5] ARM: EXYNOS: Add arm-pmu DT binding for exynos421x
In-Reply-To: <1349662630-11607-6-git-send-email-chanho61.park@samsung.com>
References: <1349662630-11607-1-git-send-email-chanho61.park@samsung.com>
 <1349662630-11607-6-git-send-email-chanho61.park@samsung.com>
Message-ID: <020f01cdb127$0357a990$0a06fcb0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Chanho Park wrote:
> 
> This patch adds a arm-pmu node to bind device tree for exynos4210.
> The exynos4210 and 4212 have two cpus which includes a pmu. In contrast,
> the
> exynos4412 has 4 cpus and pmus. We need to define two more pmus for this
> type
> board. However, supporting arm-pmu for the exynos4412 will handle it later
> because there is no dts support for 4412 based board.
> 
> Signed-off-by: Chanho Park <chanho61.park@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/boot/dts/exynos4210.dtsi |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/exynos4210.dtsi
> b/arch/arm/boot/dts/exynos4210.dtsi
> index 214c557..90f9aed 100644
> --- a/arch/arm/boot/dts/exynos4210.dtsi
> +++ b/arch/arm/boot/dts/exynos4210.dtsi
> @@ -42,6 +42,12 @@
>  			     <0 12 0>, <0 13 0>, <0 14 0>, <0 15 0>;
>  	};
> 
> +	pmu {
> +		compatible = "arm,cortex-a9-pmu";
> +		interrupt-parent = <&combiner>;
> +		interrupts = <2 2>, <3 2>;
> +	};
> +
>  	pinctrl_0: pinctrl at 11400000 {
>  		compatible = "samsung,pinctrl-exynos4210";
>  		reg = <0x11400000 0x1000>;
> --
> 1.7.9.5

Looks OK, applied.
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

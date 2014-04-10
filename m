From: chanho61.park@samsung.com (Chanho Park)
Date: Thu, 10 Apr 2014 19:23:48 +0900
Subject: [PATCH 21/27] ARM: dts: exynos3250: Add PMU dt data
In-Reply-To: <1397124377-16969-13-git-send-email-cw00.choi@samsung.com>
References: <1397122658-16013-1-git-send-email-cw00.choi@samsung.com>
 <1397124377-16969-13-git-send-email-cw00.choi@samsung.com>
Message-ID: <002701cf54a6$f6593720$e30ba560$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> -----Original Message-----
> From: linux-arm-kernel [mailto:linux-arm-kernel-
> bounces at lists.infradead.org] On Behalf Of Chanwoo Choi
> Sent: Thursday, April 10, 2014 7:06 PM
> To: kgene.kim at samsung.com; t.figa at samsung.com; linux-samsung-
> soc at vger.kernel.org
> Cc: hyunhee.kim at samsung.com; sw0312.kim at samsung.com; linux-
> kernel at vger.kernel.org; yj44.cho at samsung.com; inki.dae at samsung.com;
> cw00.choi at samsung.com; kyungmin.park at samsung.com; linux-arm-
> kernel at lists.infradead.org
> Subject: [PATCH 21/27] ARM: dts: exynos3250: Add PMU dt data
> 
> From: Hyunhee Kim <hyunhee.kim@samsung.com>
> 
> ARM CPU has its own PMU (Performance Monitoring Unit). This patch add
> PMU dt
> data to support PMU for CPU. Exynos3250 has four PMU interrupts.
> 
> Signed-off-by: Hyunhee Kim <hyunhee.kim@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/boot/dts/exynos3250.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/exynos3250.dtsi
> b/arch/arm/boot/dts/exynos3250.dtsi
> index ceed761..2f0ca32 100644
> --- a/arch/arm/boot/dts/exynos3250.dtsi
> +++ b/arch/arm/boot/dts/exynos3250.dtsi
> @@ -280,4 +280,9 @@
>  		pinctrl-0 = <&i2c7_bus>;
>  		status = "disabled";
>  	};
> +
> +	pmu {
> +		compatible = "arm,cortex-a7-pmu";
> +		interrupts = <0 18 0>, <0 19 0>, <0 20 0>, <0 21 0>;
> +	};

As I know, the exynos3250 has two CPU cores. Why does it have four pmu
interrupts?
IMO it is sufficient it has only two interrupts.

Best Regards,
Chanho Park 

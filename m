From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 11 Dec 2015 08:46:46 +0530
Subject: [PATCH v5 3/7] ARM: dts: Exynos542x/5800: add CPU OPP properties
In-Reply-To: <1449766729-435-4-git-send-email-b.zolnierkie@samsung.com>
References: <1449766729-435-1-git-send-email-b.zolnierkie@samsung.com>
 <1449766729-435-4-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <20151211031646.GL3612@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10-12-15, 17:58, Bartlomiej Zolnierkiewicz wrote:
> diff --git a/arch/arm/boot/dts/exynos5422-cpus.dtsi b/arch/arm/boot/dts/exynos5422-cpus.dtsi
> index b7f60c8..9a5131d 100644
> --- a/arch/arm/boot/dts/exynos5422-cpus.dtsi
> +++ b/arch/arm/boot/dts/exynos5422-cpus.dtsi
> @@ -20,8 +20,10 @@
>  	device_type = "cpu";
>  	compatible = "arm,cortex-a7";
>  	reg = <0x100>;
> +	clocks = <&clock CLK_KFC_CLK>;
>  	clock-frequency = <1000000000>;
>  	cci-control-port = <&cci_control0>;
> +	operating-points-v2 = <&cpu1_opp_table>;
>  };

Why do you need to update this file? This file is included by
exynos5422-odroidxu3-common.dtsi, which already inherits cpus nodes
from exynos5800.dtsi (which inherits exynos5420.dtsi).

i.e. operating-points-v2 should already be set.

-- 
viresh

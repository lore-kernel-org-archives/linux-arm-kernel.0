From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 7 Sep 2015 11:29:03 +0530
Subject: [PATCH v3 3/3] ARM: dts: add suspend opp to exynos4412
In-Reply-To: <1441303892-32004-4-git-send-email-b.zolnierkie@samsung.com>
References: <1441303892-32004-1-git-send-email-b.zolnierkie@samsung.com>
 <1441303892-32004-4-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <20150907055903.GD26760@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03-09-15, 20:11, Bartlomiej Zolnierkiewicz wrote:
> Mark 800MHz OPP as a suspend opp for Exynos4412 based
> boards so effectively cpufreq-dt driver behavior w.r.t.
> suspend frequency matches what the old exynos-cpufreq
> driver has been doing.
> 
> This patch fixes suspend/resume support on Exynos4412 based
> Trats2 board and reboot hang on Exynos4412 based Odroid U3
> board.
> 
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Thomas Abraham <thomas.ab@samsung.com>
> Cc: Javier Martinez Canillas <javier@osg.samsung.com>
> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  arch/arm/boot/dts/exynos4412.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
> index ca0e3c1..294cfe4 100644
> --- a/arch/arm/boot/dts/exynos4412.dtsi
> +++ b/arch/arm/boot/dts/exynos4412.dtsi
> @@ -98,6 +98,7 @@
>  			opp-hz = /bits/ 64 <800000000>;
>  			opp-microvolt = <1000000>;
>  			clock-latency-ns = <200000>;
> +			opp-suspend;
>  		};
>  		opp07 {
>  			opp-hz = /bits/ 64 <900000000>;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

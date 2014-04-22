From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 22 Apr 2014 12:38:25 +0200
Subject: [PATCH 3/4] exynos: cpuidle: do not allow cpuidle registration
 for Exynos5420
In-Reply-To: <1398080958-21677-4-git-send-email-chander.kashyap@linaro.org>
References: <1398080958-21677-1-git-send-email-chander.kashyap@linaro.org>
 <1398080958-21677-4-git-send-email-chander.kashyap@linaro.org>
Message-ID: <535646A1.1020201@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/21/2014 01:49 PM, Chander Kashyap wrote:
> Exynos5420 is big.Little Soc. It uses cpuidle-big-litle generic cpuidle driver.
> Hence do not allow exynos cpuidle driver registration for Exynos5420.
>
> Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
> Signed-off-by: Chander Kashyap <k.chander@samsung.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

but will conflict with:

http://www.spinics.net/lists/arm-kernel/msg319862.html

>   arch/arm/mach-exynos/cpuidle.c |    3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-exynos/cpuidle.c
> index c57cae0..242f75d 100644
> --- a/arch/arm/mach-exynos/cpuidle.c
> +++ b/arch/arm/mach-exynos/cpuidle.c
> @@ -219,6 +219,9 @@ static int exynos_cpuidle_probe(struct platform_device *pdev)
>   	int cpu_id, ret;
>   	struct cpuidle_device *device;
>
> +	if (soc_is_exynos5420())
> +		return -ENODEV;
> +
>   	if (soc_is_exynos5250())
>   		exynos5_core_down_clk();
>
>


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

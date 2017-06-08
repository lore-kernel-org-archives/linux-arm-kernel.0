From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 8 Jun 2017 09:17:09 +0530
Subject: [PATCH] cpufreq: exynos5440: Fix inconsistent indenting
In-Reply-To: <20170607181324.32199-1-krzk@kernel.org>
References: <20170607181324.32199-1-krzk@kernel.org>
Message-ID: <20170608034709.GA4634@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07-06-17, 20:13, Krzysztof Kozlowski wrote:
> Fix inconsistent indenting and unneeded white space in assignment.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/cpufreq/exynos5440-cpufreq.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/exynos5440-cpufreq.c b/drivers/cpufreq/exynos5440-cpufreq.c
> index 9180d34cc9fc..b6b369c22272 100644
> --- a/drivers/cpufreq/exynos5440-cpufreq.c
> +++ b/drivers/cpufreq/exynos5440-cpufreq.c
> @@ -173,12 +173,12 @@ static void exynos_enable_dvfs(unsigned int cur_frequency)
>  	/* Enable PSTATE Change Event */
>  	tmp = __raw_readl(dvfs_info->base + XMU_PMUEVTEN);
>  	tmp |= (1 << PSTATE_CHANGED_EVTEN_SHIFT);
> -	 __raw_writel(tmp, dvfs_info->base + XMU_PMUEVTEN);
> +	__raw_writel(tmp, dvfs_info->base + XMU_PMUEVTEN);
>  
>  	/* Enable PSTATE Change IRQ */
>  	tmp = __raw_readl(dvfs_info->base + XMU_PMUIRQEN);
>  	tmp |= (1 << PSTATE_CHANGED_IRQEN_SHIFT);
> -	 __raw_writel(tmp, dvfs_info->base + XMU_PMUIRQEN);
> +	__raw_writel(tmp, dvfs_info->base + XMU_PMUIRQEN);
>  
>  	/* Set initial performance index */
>  	cpufreq_for_each_entry(pos, freq_table)
> @@ -330,7 +330,7 @@ static int exynos_cpufreq_probe(struct platform_device *pdev)
>  	struct resource res;
>  	unsigned int cur_frequency;
>  
> -	np =  pdev->dev.of_node;
> +	np = pdev->dev.of_node;
>  	if (!np)
>  		return -ENODEV;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

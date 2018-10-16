From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Tue, 16 Oct 2018 09:44:58 +0900
Subject: [PATCH v2 1/6] clocksource: exynos_mct: Remove dead code
In-Reply-To: <20181015123112.9379-2-m.szyprowski@samsung.com>
References: <20181015123112.9379-1-m.szyprowski@samsung.com>
 <CGME20181015123134eucas1p2bca15d1e0f54c0a580c04d9af7411f68@eucas1p2.samsung.com>
 <20181015123112.9379-2-m.szyprowski@samsung.com>
Message-ID: <5BC5348A.7010308@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018? 10? 15? 21:31, Marek Szyprowski wrote:
> Exynos Multi-Core Timer driver is used only on device-tree based
> systems, so remove non-dt related code. In case of !CONFIG_OF
> the code is anyway equal because of_irq_count() has a stub
> returning 0.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/clocksource/exynos_mct.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
> index 7a244b681876..43b335ff4a96 100644
> --- a/drivers/clocksource/exynos_mct.c
> +++ b/drivers/clocksource/exynos_mct.c
> @@ -581,11 +581,7 @@ static int __init mct_init_dt(struct device_node *np, unsigned int int_type)
>  	 * timer irqs are specified after the four global timer
>  	 * irqs are specified.
>  	 */
> -#ifdef CONFIG_OF
>  	nr_irqs = of_irq_count(np);
> -#else
> -	nr_irqs = 0;
> -#endif
>  	for (i = MCT_L0_IRQ; i < nr_irqs; i++)
>  		mct_irqs[i] = irq_of_parse_and_map(np, i);
>  
> 

I agree that Exynos MCT timer is only used by device-tree.
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

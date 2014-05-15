From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Thu, 15 May 2014 23:26:51 +0200
Subject: [PATCH v5 5/6] exynos: cpuidle: do not allow cpuidle registration
 for Exynos5420
In-Reply-To: <1400054637-21505-6-git-send-email-chander.kashyap@linaro.org>
References: <ANuQgHGSPJ45tbrVppAVpOqF0OfHacPWfX=S5mOVxTPr66f7vg@mail.gmail.com>
 <1400054637-21505-1-git-send-email-chander.kashyap@linaro.org>
 <1400054637-21505-6-git-send-email-chander.kashyap@linaro.org>
Message-ID: <5375311B.2010202@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chander,

On 14.05.2014 10:03, Chander Kashyap wrote:
> Exynos5420 is big.Little Soc. It uses cpuidle-big-litle generic cpuidle driver.
> Hence do not allow exynos cpuidle driver registration for Exynos5420.
> 
> Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
> Signed-off-by: Chander Kashyap <k.chander@samsung.com>
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  arch/arm/mach-exynos/cpuidle.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-exynos/cpuidle.c
> index 3dd385e..807a386 100644
> --- a/arch/arm/mach-exynos/cpuidle.c
> +++ b/arch/arm/mach-exynos/cpuidle.c
> @@ -218,6 +218,9 @@ static int exynos_cpuidle_probe(struct platform_device *pdev)
>  	int cpu_id, ret;
>  	struct cpuidle_device *device;
>  
> +	if (soc_is_exynos5420())
> +		return -ENODEV;
> +
>  	if (soc_is_exynos5250())
>  		exynos5_core_down_clk();
>  
> 

Why not put this in exynos.c in exynos_dt_machine_init(), so
exynos_cpuidle_init() is called only if not running on Exynos5420?

Best regards,
Tomasz

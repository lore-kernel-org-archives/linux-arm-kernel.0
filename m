From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 14 Apr 2011 20:32:50 +0530
Subject: [PATCH linux-omap-pm/pm-wip/cpufreq] OMAP2PLUS: cpufreq: Fix
	typo when attempting to set mpu_clk for OMAP4
In-Reply-To: <1302787318-6650-1-git-send-email-jhnikula@gmail.com>
References: <1302787318-6650-1-git-send-email-jhnikula@gmail.com>
Message-ID: <4DA70C9A.7080805@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/14/2011 6:51 PM, Jarkko Nikula wrote:
> Fix this typo as there is no dpll_mpu_ck for OMAP3 and code flow is clearly
> trying to set mpu_clk for OMAP4 for which this dpll_mpu_ck is available.
>
> Signed-off-by: Jarkko Nikula<jhnikula@gmail.com>
> ---
>   arch/arm/mach-omap2/omap2plus-cpufreq.c |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap2plus-cpufreq.c b/arch/arm/mach-omap2/omap2plus-cpufreq.c
> index 8d472f6..d53ce23 100644
> --- a/arch/arm/mach-omap2/omap2plus-cpufreq.c
> +++ b/arch/arm/mach-omap2/omap2plus-cpufreq.c
> @@ -161,7 +161,7 @@ static int __cpuinit omap_cpu_init(struct cpufreq_policy *policy)
>   		mpu_clk = clk_get(NULL, "virt_prcm_set");
>   	else if (cpu_is_omap34xx())
>   		mpu_clk = clk_get(NULL, "dpll1_ck");
> -	else if (cpu_is_omap34xx())
> +	else if (cpu_is_omap44xx())
My Bad :(
Thanks Jarkko for finding this.

Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

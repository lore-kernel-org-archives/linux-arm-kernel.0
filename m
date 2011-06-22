From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Wed, 22 Jun 2011 16:10:45 +0400
Subject: [PATCH 7/7] ARM: EXYNOS4: Move S5P_CENTRAL_SEQ_CONFIGURATION
	setting	for PM
In-Reply-To: <1308732405-16664-8-git-send-email-kgene.kim@samsung.com>
References: <1308732405-16664-1-git-send-email-kgene.kim@samsung.com>
	<1308732405-16664-8-git-send-email-kgene.kim@samsung.com>
Message-ID: <4E01DBC5.7000006@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 22-06-2011 12:46, Kukjin Kim wrote:

> From: Jaecheol Lee<jc.lee@samsung.com>

> We need to balance between set and check S5P_CENTRAL_SEQ_CONFIGURATION
> register in syscore_ops suspend/resume function when failure in enter
> suspend mode. Moved this register setting for PM for the purpose of balancing.

> Signed-off-by: Jaecheol Lee<jc.lee@samsung.com>
> Signed-off-by: Kukjin Kim<kgene.kim@samsung.com>
> ---
>   arch/arm/mach-exynos4/pm.c |   22 ++++++++++++++--------
>   1 files changed, 14 insertions(+), 8 deletions(-)

> diff --git a/arch/arm/mach-exynos4/pm.c b/arch/arm/mach-exynos4/pm.c
> index b037fba..a103c13 100644
> --- a/arch/arm/mach-exynos4/pm.c
> +++ b/arch/arm/mach-exynos4/pm.c
[...]
> @@ -413,6 +405,19 @@ static __init int exynos4_pm_drvinit(void)
>   }
>   arch_initcall(exynos4_pm_drvinit);
>
> +static int exynos4_pm_suspend(void)
> +{
> +	unsigned long tmp;
> +
> +	/* Setting Central Sequence Register for power down mode */
> +
> +	tmp = __raw_readl(S5P_CENTRAL_SEQ_CONFIGURATION);
> +	tmp &= ~(S5P_CENTRAL_LOWPWR_CFG);

    Could drop useless parens, while at it.

WBR, Sergei

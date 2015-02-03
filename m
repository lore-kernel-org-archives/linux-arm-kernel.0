From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 03 Feb 2015 09:06:13 +0100
Subject: [RESEND PATCH] ARM: EXYNOS: Add missing static to file-scope
 declarations
In-Reply-To: <06c201d03f67$48da45b0$da8ed110$@kernel.org>
References: <1420819476-23344-1-git-send-email-k.kozlowski@samsung.com>
 <06c201d03f67$48da45b0$da8ed110$@kernel.org>
Message-ID: <1422950773.10086.1.camel@AMDC1943>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On wto, 2015-02-03 at 13:10 +0900, Kukjin Kim wrote:
> Krzysztof Kozlowski wrote:
> > 
> > The 'pm_data', 'exynos_release_ret_regs' and
> > 'exynos5420_release_ret_regs' are not exported nor used outside of
> > suspend.c file. Make them static.
> > 
> > This fixes following sparse warnings:
> > arch/arm/mach-exynos/suspend.c:83:23: warning: symbol 'pm_data' was not declared. Should it be static?
> > arch/arm/mach-exynos/suspend.c:106:14: warning: symbol 'exynos_release_ret_regs' was not declared.
> > Should it be static?
> > arch/arm/mach-exynos/suspend.c:117:14: warning: symbol 'exynos5420_release_ret_regs' was not declared.
> > Should it be static?
> > 
> > Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > ---
> >  arch/arm/mach-exynos/suspend.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/arm/mach-exynos/suspend.c b/arch/arm/mach-exynos/suspend.c
> > index 342797b9bf3b..fef091f8e59f 100644
> > --- a/arch/arm/mach-exynos/suspend.c
> > +++ b/arch/arm/mach-exynos/suspend.c
> > @@ -75,7 +75,7 @@ struct exynos_pm_data {
> >  	int (*cpu_suspend)(unsigned long);
> >  };
> > 
> > -struct exynos_pm_data *pm_data;
> > +static struct exynos_pm_data *pm_data;
> > 
> >  static int exynos5420_cpu_state;
> >  static unsigned int exynos_pmu_spare3;
> > @@ -98,7 +98,7 @@ static const struct exynos_wkup_irq exynos5250_wkup_irq[] = {
> >  	{ /* sentinel */ },
> >  };
> > 
> > -unsigned int exynos_release_ret_regs[] = {
> > +static unsigned int exynos_release_ret_regs[] = {
> >  	S5P_PAD_RET_MAUDIO_OPTION,
> >  	S5P_PAD_RET_GPIO_OPTION,
> >  	S5P_PAD_RET_UART_OPTION,
> > @@ -109,7 +109,7 @@ unsigned int exynos_release_ret_regs[] = {
> >  	REG_TABLE_END,
> >  };
> > 
> > -unsigned int exynos5420_release_ret_regs[] = {
> > +static unsigned int exynos5420_release_ret_regs[] = {
> >  	EXYNOS_PAD_RET_DRAM_OPTION,
> >  	EXYNOS_PAD_RET_MAUDIO_OPTION,
> >  	EXYNOS_PAD_RET_JTAG_OPTION,
> > --
> 
> Looks ok to me, how about re-spin this patch including following?
> 
> ...
> +static unsigned int exynos3250_release_ret_regs[] = {

Sure, I'll resend extended version.

Best regards,
Krzysztof

> ...
> 
> Thanks,
> Kukjin

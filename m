From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 05 Feb 2015 08:14:46 +0100
Subject: [v2,3/3] ARM: EXYNOS: Remove left over 'extra_save'
In-Reply-To: <54D2F646.3090306@samsung.com>
References: <1422961601-7087-3-git-send-email-k.kozlowski@samsung.com>
 <54D2F646.3090306@samsung.com>
Message-ID: <1423120486.29408.2.camel@AMDC1943>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On czw, 2015-02-05 at 10:19 +0530, Pankaj Dubey wrote:
> Hi Krzysztof,
> 
> On Tuesday 03 February 2015 04:36 PM, Krzysztof Kozlowski wrote:
> > Since 32b0aa9aaeb4 ("ARM: EXYNOS: Remove i2c sys configuration related
> > code") the Exynos 5250 no longer saves additional registers under
> > 'exynos_pm_data.extra_save' field.
> >
> > No one else uses this code so get rid of it making also 'exynos_pm_data'
> > const everywhere.
> >
> > Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> >
> > ---
> > Changes since v1:
> > 1. New patch.
> > ---
> >   arch/arm/mach-exynos/suspend.c | 13 ++-----------
> >   1 file changed, 2 insertions(+), 11 deletions(-)
> >
> > diff --git a/arch/arm/mach-exynos/suspend.c b/arch/arm/mach-exynos/suspend.c
> > index e6c961126087..d56bd6ca5e86 100644
> > --- a/arch/arm/mach-exynos/suspend.c
> > +++ b/arch/arm/mach-exynos/suspend.c
> > @@ -63,7 +63,6 @@ static struct sleep_save exynos_core_save[] = {
> >
> >   struct exynos_pm_data {
> >   	const struct exynos_wkup_irq *wkup_irq;
> > -	struct sleep_save *extra_save;
> >   	int num_extra_save;
> 
> 'num_extra_save' can be removed at the same time.
> 
> Rest changes looks ok.

Right, thanks for pointing this out. I'll resend the patchset.

Best regards,
Krzysztof
> 
> Thanks,
> Pankaj Dubey

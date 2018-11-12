From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 12 Nov 2018 21:25:43 +0100
Subject: [PATCH v3] ARM: SAMSUNG: limit SAMSUNG_PM_DEBUG config option to
 non-Exynos platforms
In-Reply-To: <CAJKOXPcFnkwZfCg8q429L6HRfNxubTaoa+BRZ-1h3ti3Q2EAxw@mail.gmail.com>
References: <CGME20181015155001eucas1p249f539be47eaff0d10ddc74e1f681b37@eucas1p2.samsung.com>
 <20181015155001eucas1p249f539be47eaff0d10ddc74e1f681b37~d0vYKtP7-2027420274eucas1p2g@eucas1p2.samsung.com>
 <CAJKOXPcFnkwZfCg8q429L6HRfNxubTaoa+BRZ-1h3ti3Q2EAxw@mail.gmail.com>
Message-ID: <20181112202543.GB25275@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 16, 2018 at 03:04:52PM +0200, Krzysztof Kozlowski wrote:
> On Mon, 15 Oct 2018 at 17:50, Bartlomiej Zolnierkiewicz
> <b.zolnierkie@samsung.com> wrote:
> >
> > "Samsung PM Suspend debug" feature (controlled by SAMSUNG_PM_DEBUG
> > config option) is not working properly (debug messages are not
> > displayed after resume) on Exynos platforms because GPIOs restore
> > code is not implemented.
> >
> > Add PLAT_S3C24XX, ARCH_S3C64XX and ARCH_S5PV210 dependencies to
> > SAMSUNG_PM_DEBUG config option to hide it on Exynos platforms.
> > Then convert Exynos code to not require <plat/pm-common.h>
> > header (use pr_debug() directly instead of S3C_PMDBG() macro and
> > remove redundant s3c_pm_*() calls).
> >
> > Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > ---
> > v3:
> > - don't move PM to the line below in Kconfig
> >
> > v2:
> > - convert Exynos code to not require <plat/pm-common.h> header
> >
> > Should by applied on top of "[PATCH] ARM: EXYNOS: remove no longer
> > needed s3c_pm_check_*() calls".
> >
> >  arch/arm/mach-exynos/suspend.c |   14 ++++----------
> >  arch/arm/plat-samsung/Kconfig  |    1 +
> >  2 files changed, 5 insertions(+), 10 deletions(-)
> 
> Thanks. This and the other one (removing s3c_pm_check_*()) look OK
> although it is too late for another pull so this will wait for next
> cycle.

Hi,

This does not longer apply. Probably because of my changes around eint
wakeup mask. Could you rebase?

Best regards,
Krzysztof

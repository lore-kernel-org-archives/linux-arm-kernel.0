From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Tue, 05 Aug 2014 14:04:44 +0200
Subject: [PATCH v3 0/4] ARM: EXYNOS: cpuidle: fix AFTR mode on boards with
 secure firmware enabled
In-Reply-To: <53D5FF06.6080904@linaro.org>
References: <1404926274-18411-1-git-send-email-b.zolnierkie@samsung.com>
 <53D5FF06.6080904@linaro.org>
Message-ID: <1616004.BFfRa8qesz@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Daniel,

On Monday, July 28, 2014 09:43:02 AM Daniel Lezcano wrote:
> On 07/09/2014 07:17 PM, Bartlomiej Zolnierkiewicz wrote:
> > Hi,
> >
> > This patch series adds support for AFTR idle mode on boards with
> > secure firmware enabled and allows EXYNOS cpuidle driver usage on
> > Exynos4x12 SoCs.
> >
> > It has been tested on Trats2 board (using Exynos4412 SoC with secure
> > firmware enabled) on which AFTR mode reduces power consumption by ~12%
> > when EXYNOS cpuidle driver is enabled (in both cases the default
> > exynos_defconfig config is used and CPU1-3 are offlined).
> 
> 
> Hi Bartlomiej,
> 
> what is the status of this patchset ? Is it supposed to land for 3.17 ?

I posted v4 yesterday:
http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg35197.html

When it comes to merging the patchset for 3.17 it is up to Kukjin.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> Thanks
> 
>    -- Daniel
> 
> > v3:
> > - rebased on top of next-20140708 +
> >    http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg32809.html
> >    (with rejects fixed)
> >    http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg32808.html
> >    http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg32991.html
> >    (with rejects fixed in patch #2)
> > - addressed review comments from Tomasz Figa and Daniel Lezcano
> >
> > Best regards,
> > --
> > Bartlomiej Zolnierkiewicz
> > Samsung R&D Institute Poland
> > Samsung Electronics
> >
> >
> > Bartlomiej Zolnierkiewicz (4):
> >    ARM: EXYNOS: PM: replace EXYNOS_BOOT_VECTOR_* macros by static inlines
> >    ARM: EXYNOS: add AFTR mode support to firmware do_idle method
> >    ARM: EXYNOS: cpuidle: add secure firmware support to AFTR mode code
> >    ARM: EXYNOS: cpuidle: allow driver usage on Exynos4x12 SoCs
> >
> >   arch/arm/include/asm/firmware.h  |  2 +-
> >   arch/arm/mach-exynos/common.h    |  7 ++++++-
> >   arch/arm/mach-exynos/exynos.c    |  3 ++-
> >   arch/arm/mach-exynos/firmware.c  | 36 ++++++++++++++++++++++++++----------
> >   arch/arm/mach-exynos/pm.c        | 39 +++++++++++++++++++++++++++++----------
> >   drivers/cpuidle/cpuidle-exynos.c |  6 +++---
> >   6 files changed, 67 insertions(+), 26 deletions(-)

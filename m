From: kgene@kernel.org (Kukjin Kim)
Date: Wed, 08 Oct 2014 17:37:48 +0900
Subject: [PATCH v9 0/2] Adds PMU and S2R support for exynos5420
In-Reply-To: <CAGm_ybjP1WQfbyWR5GwQ6QnUjsy4qB_678+L=jgmMzz-rWkb0w@mail.gmail.com>
References: <1412673723-15551-1-git-send-email-vikas.sajjan@samsung.com>
 <CAGm_ybjP1WQfbyWR5GwQ6QnUjsy4qB_678+L=jgmMzz-rWkb0w@mail.gmail.com>
Message-ID: <016401cfe2d3$23f3f0c0$6bdbd240$@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vikas Sajjan wrote:
> 
> Hi Kukjin,
> 
Hi,
> 
> On Tue, Oct 7, 2014 at 3:07 PM, Vikas Sajjan <vikas.sajjan@samsung.com> wrote:
> > Rebased on
> > 1] Kukjin Kim's tree, for-next branch
> > https://git.kernel.org/cgit/linux/kernel/git/kgene/linux-samsung.git/log/?h=for-next
> > 2] Pankaj Dubey's v9 PMU patchset
> > http://www.spinics.net/lists/arm-kernel/msg367939.html
> >
> > changes since v8:
> >         - addressed abhilash's comments to remove the restoring of
> >           the CPU0 low power state register, since it will taken care in mcpm s2r
> >           patch from abhilash.
> >
> > changes since v7:
> >         - rebased on pankaj's latest patchset.
> >
> > changes since v6:
> >         - rebased on 3.17.rc1.
> >
> > changes since v5:
> >         - Refactored pm.c to use DT based lookup as suggested by Tomasz Figa.
> >
> > changes since v4:
> >         - Adressed comments from Tomasz figa and rebased on Pankaj Dubey's v5 PMU patchset
> >
> > changes since v3:
> > Addressed the following comments from Pankaj Dubey, Bartlomiej Zolnierkiewicz,
> > Tomasz Figa and Alim Akhtar:
> >         - Moved EXYNOS5420_USE_STANDBY_WFI_ALL define to regs-pmu.h.
> >         - Merged exynos5420_set_core_flag function into powerdown_conf.
> >         - Removed XXTI_DURATION3 register setting.
> >         - Updated the commit message and ordered the clock registers in clock
> >           patch.
> >         - Removed the code for SYS_DISP1_BLK_CFG handling.
> >         - Modified SoC checks to A9 specific checks in PM code.
> >         - Updated some comments in the code and added macros for register offsets.
> >         - Fixed code which was changing pad retention code for older SoCs.
> >
> > changes since v2:
> >         - Addressed comments from Tomasz figa
> >         - rebased on Pankaj's V3 patchset https://lkml.org/lkml/2014/5/2/612
> >         - dropped patch "ARM: dts: Add node for GPIO keys on SMDK5420",
> >           will be sent separately.
> >
> > changes since v1:
> >         - Addressed comments from Tomasz figa.
> >         - restructured/consolidated as per Tomasz figa's PM consolidations for exynos
> >
> > Tested on Kukjin Kim's tree, for-next branch +
> > 1] http://www.spinics.net/lists/linux-samsung-soc/msg33750.html
> > 2] https://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg37260.html
> > 3] with the CLK_IGNORE_UNUSED flag for aclk200_disp1 CLK
> >
> > on Exynos5420 based chromebook (peach-pit board)
> >
> > Below procedures were followed to test S2R:
> > Procedure A:
> >         1. make multi_v7_defconfig
> >         2  enable MCPM for 5420
> >         3. enable S3C RTC
> >         5. echo +20 > /sys/class/rtc/rtc0/wakealarm && echo mem > /sys/power/state
> > Procedure B:
> >         1. make exynos_defconfig
> >         4. echo +20 > /sys/class/rtc/rtc0/wakealarm && echo mem > /sys/power/state
> >
> > Abhilash Kesavan (1):
> >   ARM: exynos5: Add PMU support for 5420
> >
> > Vikas Sajjan (1):
> >   ARM: exynos5: Add Suspend-to-RAM support for 5420
> >
> >  arch/arm/mach-exynos/pmu.c      |  287 +++++++++++++++++++++++++++++++++++++++
> >  arch/arm/mach-exynos/regs-pmu.h |  227 +++++++++++++++++++++++++++++++
> >  arch/arm/mach-exynos/suspend.c  |  151 +++++++++++++++++++-
> >  3 files changed, 663 insertions(+), 2 deletions(-)
> >
> 
> Can you please pick this series.
> 
Yes, sure I will queue this series after -rc1 release.

Thanks,
Kukjin

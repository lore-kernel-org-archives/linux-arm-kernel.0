From: vikas.sajjan@samsung.com (Vikas Sajjan)
Date: Sun, 14 Sep 2014 20:27:28 +0530
Subject: [PATCH v7 0/2] Adds PMU and S2R support for exynos5420
In-Reply-To: <1408625982-3267-1-git-send-email-vikas.sajjan@samsung.com>
References: <1408625982-3267-1-git-send-email-vikas.sajjan@samsung.com>
Message-ID: <CAGm_ybh-R1GsHF-BRhRYQKkCpQFQSE6Mem=A3kz=H3Bemor9xA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,


On Thu, Aug 21, 2014 at 6:29 PM, Vikas Sajjan <vikas.sajjan@samsung.com> wrote:
> Rebased on
> 1] Kukjin Kim's tree, master branch
> http://git.kernel.org/cgit/linux/kernel/git/kgene/linux-samsung.git/log/
> 2] Pankaj Dubey's v7 PMU patchset
> https://lkml.org/lkml/2014/7/9/2
> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-July/270655.html
> 3] My pm.c refactoring patchset
> http://www.spinics.net/lists/linux-samsung-soc/msg35740.html
>
> changes since v6:
>         - rebased on 3.17.rc1.
>
> changes since v5:
>         - Refactored pm.c to use DT based lookup as suggested by Tomasz Figa.
>
> changes since v4:
>         - Adressed comments from Tomasz figa and rebased on Pankaj Dubey's v5 PMU patchset
>
> changes since v3:
> Addressed the following comments from Pankaj Dubey, Bartlomiej Zolnierkiewicz,
> Tomasz Figa and Alim Akhtar:
>         - Moved EXYNOS5420_USE_STANDBY_WFI_ALL define to regs-pmu.h.
>         - Merged exynos5420_set_core_flag function into powerdown_conf.
>         - Removed XXTI_DURATION3 register setting.
>         - Updated the commit message and ordered the clock registers in clock
>           patch.
>         - Removed the code for SYS_DISP1_BLK_CFG handling.
>         - Modified SoC checks to A9 specific checks in PM code.
>         - Updated some comments in the code and added macros for register offsets.
>         - Fixed code which was changing pad retention code for older SoCs.
>
> changes since v2:
>         - Addressed comments from Tomasz figa
>         - rebased on Pankaj's V3 patchset https://lkml.org/lkml/2014/5/2/612
>         - dropped patch "ARM: dts: Add node for GPIO keys on SMDK5420",
>           will be sent separately.
>
> changes since v1:
>         - Addressed comments from Tomasz figa.
>         - restructured/consolidated as per Tomasz figa's PM consolidations for exynos
>
> Tested on Kukjin Kim's tree, master branch + http://www.spinics.net/lists/linux-samsung-soc/msg33750.html
>
> on Exynos5420 based chromebook (peach-pit board)
>
> PS : Not tested on exynos4 based boards.
>
> Tested-by for exynos4 would be appreciated.
>
> Below procedures were followed to test S2R:
> Procedure A:
>         1. make multi_v7_defconfig
>         2  enable MCPM for 5420
>         3. enable S3C RTC
>         4. pass "no_console_suspend" in bootargs
>         5. echo +20 > /sys/class/rtc/rtc0/wakealarm && echo mem > /sys/power/state
> Procedure B:
>         1. make exynos_defconfig
>         2  disable BL_SWITCHER
>         3. pass "no_console_suspend" in bootargs
>         4. echo +20 > /sys/class/rtc/rtc0/wakealarm && echo mem > /sys/power/state
>
> Abhilash Kesavan (2):
>   ARM: exynos5: Add PMU support for 5420
>   ARM: exynos5: Add Suspend-to-RAM support for 5420
>
>  arch/arm/mach-exynos/pm.c       |  149 +++++++++++++++++++-
>  arch/arm/mach-exynos/pmu.c      |  288 +++++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-exynos/regs-pmu.h |  229 +++++++++++++++++++++++++++++++
>  3 files changed, 665 insertions(+), 1 deletion(-)
>


Anymore comments on this....


> --
> 1.7.9.5
>

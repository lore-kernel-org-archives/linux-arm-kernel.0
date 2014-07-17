From: vikas.sajjan@samsung.com (Vikas Sajjan)
Date: Thu, 17 Jul 2014 15:47:14 +0545
Subject: [PATCH 0/3] Adds PMU and S2R support for exynos5800
In-Reply-To: <1404905147-30319-1-git-send-email-vikas.sajjan@samsung.com>
References: <1404905147-30319-1-git-send-email-vikas.sajjan@samsung.com>
Message-ID: <CAGm_ybirYq5iLS-hY8G6W-mMh2pW4ZoieuGn5iBT-X4fbBEboA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 9, 2014 at 5:10 PM, Vikas Sajjan <vikas.sajjan@samsung.com> wrote:
> Rebased on
> 1] Kukjin Kim's tree, for-next branch
> https://git.kernel.org/cgit/linux/kernel/git/kgene/linux-samsung.git/log/?h=for-next
> 2] My 5420 PMU Series :
> http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg33675.html
>
> Tested on Exynos5800 based chromebook (peach-pi board) with help of
>  1] http://www.spinics.net/lists/linux-samsung-soc/msg33750.html (modified to support 5800)
>  2] http://www.spinics.net/lists/linux-samsung-soc/msg32923.html
>
> Below are steps followed to test S2R:
>         1. make multi_v7_defconfig
>         2  enable MCPM for 5420
>         3. enable S3C RTC
>         4. pass "no_console_suspend" in bootargs
>         5. echo +20 > /sys/class/rtc/rtc0/wakealarm && echo mem > /sys/power/state
>
> Vikas Sajjan (3):
>   arm: dts: Add pmu node for exynos5800 SoC
>   arm: exynos: Add exynos5800-pmu compatible entry
>   arm: exynos: Add PMU and S2R support for exynos5800 SoC
>
>  .../devicetree/bindings/arm/samsung/pmu.txt        |    1 +
>  arch/arm/boot/dts/exynos5800.dtsi                  |    4 ++++
>  arch/arm/mach-exynos/exynos.c                      |    1 +
>  arch/arm/mach-exynos/pm.c                          |    3 +++
>  arch/arm/mach-exynos/pmu.c                         |   22 ++++++++++++++++++++
>  arch/arm/mach-exynos/regs-pmu.h                    |    3 ++-
>  6 files changed, 33 insertions(+), 1 deletion(-)


any comments on this series..


>
> --
> 1.7.9.5
>

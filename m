From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Mon, 07 Sep 2015 17:41:37 +0200
Subject: [PATCH v4 0/4] cpufreq-dt: add suspend frequency support
Message-ID: <1441640501-13613-1-git-send-email-b.zolnierkie@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patch series adds suspend frequency support (using opp-v2
bindings and suspend-opp functionality) to cpufreq-dt driver and
then adds suspend opp for Exynos4412 based boards.

This patch series fixes suspend/resume support on Exynos4412
based Trats2 board and reboot hang on Exynos4412 based Odroid
U3 board.

Changes since v3:
- fixed dev_pm_opp_get_suspend_opp() locking
- shortened variable name in dev_pm_opp_get_suspend_opp()
- adjusted cpufreq_generic_suspend() to work with cpufreq-dt
- removed no longer needed cpufreq_dt_suspend()
- added Acked-by tag from Viresh to patch #4

Changes since v2:
- rewrote to use suspend-opp functionality

Changes since v1:
- removed superfluous ";"

Depends on:
- next-20150902 branch of linux-next kernel tree

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


Bartlomiej Zolnierkiewicz (4):
  PM / OPP: add dev_pm_opp_get_suspend_opp() helper
  cpufreq: allow cpufreq_generic_suspend() to work without suspend
    frequency
  cpufreq-dt: add suspend frequency support
  ARM: dts: add suspend opp to exynos4412

 arch/arm/boot/dts/exynos4412.dtsi |  1 +
 drivers/base/power/opp.c          | 30 ++++++++++++++++++++++++++++++
 drivers/cpufreq/cpufreq-dt.c      | 11 +++++++++++
 drivers/cpufreq/cpufreq.c         |  4 ++--
 include/linux/pm_opp.h            |  6 ++++++
 5 files changed, 50 insertions(+), 2 deletions(-)

-- 
1.9.1

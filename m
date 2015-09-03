From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Thu, 03 Sep 2015 20:11:29 +0200
Subject: [PATCH v3 0/3] cpufreq-dt: add suspend frequency support
Message-ID: <1441303892-32004-1-git-send-email-b.zolnierkie@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patch series adds suspend frequency support (using opp-v2
bindings and suspend-opp functionality) to cpufreq-dt driver and
then adds suspend opp for Exynos4412 based boards.

This patch series fixes suspend/resume support on Exynos4412
based Trats2 board and reboot hang on Exynos4412 based Odroid
U3 board.

Changes since v2:
- rewrited to use suspend-opp functionality

Changes since v1:
- removed superfluous ";"

Depends on:
- next-20150902 branch of linux-next kernel tree

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


Bartlomiej Zolnierkiewicz (3):
  PM / OPP: add dev_pm_opp_get_suspend_opp() helper
  cpufreq-dt: add suspend frequency support
  ARM: dts: add suspend opp to exynos4412

 arch/arm/boot/dts/exynos4412.dtsi |  1 +
 drivers/base/power/opp.c          | 28 ++++++++++++++++++++++++++++
 drivers/cpufreq/cpufreq-dt.c      | 32 ++++++++++++++++++++++++++++++++
 include/linux/pm_opp.h            |  6 ++++++
 4 files changed, 67 insertions(+)

-- 
1.9.1

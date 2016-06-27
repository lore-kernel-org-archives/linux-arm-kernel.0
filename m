From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Mon, 27 Jun 2016 13:26:06 +0200
Subject: [RFC PATCH 0/4] ARM: remove big.LITTLE switcher support
Message-ID: <1467026770-5699-1-git-send-email-b.zolnierkie@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

It seems that in mainline kernel big.LITTLE switcher support
may be usable only on ARM Versatile Express TC2 platform
(but even this platform doesn't enable it in its defconfig).

The following patchset removes big.LITTLE switcher support
(from both ARM core and arm_big_little CPUfreq driver) in
favor of using HMP.

Since HMP support at scheduler level is not yet merged this
patchset is probably premature and thus is marked as RFC.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


Bartlomiej Zolnierkiewicz (4):
  ARM: remove big.LITTLE switcher support
  cpufreq: arm_big_little: remove big.LITTLE switcher support
  cpufreq: exynos: remove big.LITTLE switcher dependency
  irqchip/gic: remove big.LITTLE switcher support

 arch/arm/Kconfig                       |  19 +-
 arch/arm/common/Makefile               |   2 -
 arch/arm/common/bL_switcher.c          | 802 ---------------------------------
 arch/arm/common/bL_switcher_dummy_if.c |  71 ---
 arch/arm/include/asm/bL_switcher.h     |  77 ----
 drivers/cpufreq/arm_big_little.c       | 379 +---------------
 drivers/cpufreq/cpufreq-dt-platdev.c   |   2 -
 drivers/irqchip/irq-gic.c              | 137 ------
 8 files changed, 25 insertions(+), 1464 deletions(-)
 delete mode 100644 arch/arm/common/bL_switcher.c
 delete mode 100644 arch/arm/common/bL_switcher_dummy_if.c
 delete mode 100644 arch/arm/include/asm/bL_switcher.h

-- 
1.9.1

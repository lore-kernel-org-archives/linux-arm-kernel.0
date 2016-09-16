From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 16 Sep 2016 09:10:08 +0200
Subject: [GIT PULL] ARM: exynos: Fixes for v4.8, secound round
References: <CGME20160916071017eucas1p155978eec97e20211d9c54ef670e319eb@eucas1p1.samsung.com>
Message-ID: <1474009808-8520-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Remaining fix for this release cycle. It waited in my tree for some time
because of travel.

Best regards,
Krzysztof


The following changes since commit 326dce0734b63c3b82b6a88e5645eab8b54c6692:

  MAINTAINERS: Switch to kernel.org account for Krzysztof Kozlowski (2016-08-17 17:54:56 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-fixes-4.8-2

for you to fetch changes up to b030485220caf862c71db6fb8b8ad016ce7f7565:

  ARM: EXYNOS: Clear OF_POPULATED flag from PMU node in IRQ init callback (2016-08-30 10:49:18 +0200)

----------------------------------------------------------------
1. A recent change in populating irqchip devices from Device Tree
   broke Suspend to RAM on Exynos boards due to lack of probing of
   PMU (Power Management Unit) driver.  Multiple drivers attach to
   the PMU's DT node: irqchip, clock controller and PMU platform
   driver for handling suspend.  The new irqchip code marked the
   PMU's DT node as OF_POPULATED but we need to attach to this
   node also PMU platform driver.

2. Add Javier as additional reviewer for Exynos patches.

----------------------------------------------------------------
Javier Martinez Canillas (2):
      MAINTAINERS: Add myself as reviewer for Samsung Exynos support
      ARM: EXYNOS: Clear OF_POPULATED flag from PMU node in IRQ init callback

 MAINTAINERS                    | 1 +
 arch/arm/mach-exynos/suspend.c | 6 ++++++
 2 files changed, 7 insertions(+)

From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue,  3 Mar 2015 11:43:13 +0100
Subject: [PATCH v2 0/7] ARM: mvebu: Enable perf support
Message-ID: <1425379400-4346-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

This patch enables the performance monitoring unit found on the Armada
370, 375, 38x and XP, in order to gain hardware-assisted tracing using
perf.

Due to the way the interrupts are implemented in these SoCs, it
required some additions to the interrupt controller in order to unmask
the PMU interrupts.

While doing so, we reworked the way the PPI are supported, in order to
make the driver both easier to read and to extend.

This has been tested on an Armada XP and an Armada 385, and this serie
depends on the patch "irqchip: armada: Fix chained per-cpu interrupts"
sent previously.

Thanks!
Maxime

Changes from v1:
  - Dropped the mask/unmask refactoring
  - Rebased on top of the v2 of the chained PPI fix

Ezequiel Garcia (5):
  irqchip: armada-370-xp: Initialize per cpu registers when CONFIG_SMP=N
  irqchip: armada-370-xp: Introduce a is_percpu_irq() helper for
    readability
  ARM: mvebu: Enable Performance Monitor Unit on Armada 375 SoC
  ARM: mvebu: Enable Performance Monitor Unit on Armada 380/385 SoC
  ARM: mvebu: Enable perf support in mvebu_v7_defconfig

Maxime Ripard (2):
  irqchip: armada-370-xp: Enable the PMU interrupts
  ARM: mvebu: Enable Performance Monitor Unit on Armada XP/370 SoCs

 arch/arm/boot/dts/armada-370-xp.dtsi |  5 ++
 arch/arm/boot/dts/armada-375.dtsi    |  5 ++
 arch/arm/boot/dts/armada-38x.dtsi    |  5 ++
 arch/arm/configs/mvebu_v7_defconfig  |  1 +
 drivers/irqchip/irq-armada-370-xp.c  | 88 +++++++++++++++++++++++-------------
 5 files changed, 73 insertions(+), 31 deletions(-)

-- 
2.3.0

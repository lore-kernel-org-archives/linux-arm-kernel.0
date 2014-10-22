From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 22 Oct 2014 10:43:40 -0300
Subject: [PATCH 0/7] Armada 375/38x perf support,
 and a bonus irqchip driver simplification
Message-ID: <1413985427-20918-1-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset enables support for perf hardware events, by enabling the PMU
interrupts in the irqchip driver.

While doing this, we noticed the driver could use some cleaning to simplify
the overly complex implementation of the .map(), .unmask() and .mask()
functions.

The first three patches are the result of this cleaning effort, while the
rest of the series is the Perf support for Armada 375 and Armada 38x SoCs.

The series is based on v3.18-rc1.

Ezequiel Garcia (7):
  irqchip: armada-370-xp: Simplify interrupt map, mask and unmask
  irqchip: armada-370-xp: Initialize per cpu registers when CONFIG_SMP=N
  irqchip: armada-370-xp: Introduce a is_percpu_irq() helper for
    readability
  irqchip: armada-370-xp: Enable Performance Counter interrupts
  ARM: mvebu: Enable Performance Monitor Unit on Armada 375 SoC
  ARM: mvebu: Enable Performance Monitor Unit on Armada 380/385 SoC
  ARM: mvebu: Enable perf support in mvebu_v7_defconfig

 arch/arm/boot/dts/armada-375.dtsi   |  5 ++
 arch/arm/boot/dts/armada-38x.dtsi   |  5 ++
 arch/arm/configs/mvebu_v7_defconfig |  1 +
 drivers/irqchip/irq-armada-370-xp.c | 95 ++++++++++++++++++-------------------
 4 files changed, 58 insertions(+), 48 deletions(-)

-- 
2.1.0

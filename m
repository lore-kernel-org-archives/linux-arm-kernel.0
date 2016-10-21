From: woogyom.kim@gmail.com (Milo Kim)
Date: Fri, 21 Oct 2016 23:00:59 +0900
Subject: [PATCH 0/7] Support TPS65217 PMIC interrupt in DT
Message-ID: <20161021140106.21531-1-woogyom.kim@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

TPS65217 interrupt events include push button pressed/released, USB and AC 
voltage status change. AM335x bone based boards (like BB, BBB, BBG) have 
common PMIC interrupt pin (named NMI) of AM335x core.

This patchset support interrupts in device tree file.

Milo Kim (7):
  ARM: dts: tps65217: Specify the interrupt controller
  ARM: dts: tps65217: Add the charger device
  ARM: dts: tps65217: Add the power button device
  ARM: dts: am335x: Support the PMIC interrupt
  ARM: dts: am335x: Add the charger interrupt
  ARM: dts: am335x: Add the power button interrupt
  mfd: tps65217: Fix mismatched interrupt number

 arch/arm/boot/dts/am335x-bone-common.dtsi | 17 +++++++++++++++++
 arch/arm/boot/dts/tps65217.dtsi           | 12 ++++++++++++
 include/linux/mfd/tps65217.h              |  4 ++--
 3 files changed, 31 insertions(+), 2 deletions(-)

-- 
2.9.3

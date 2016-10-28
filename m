From: woogyom.kim@gmail.com (Milo Kim)
Date: Fri, 28 Oct 2016 21:36:54 +0900
Subject: [PATCH v2 0/8] Support TPS65217 PMIC interrupt in DT
Message-ID: <20161028123702.21849-1-woogyom.kim@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

TPS65217 interrupt events include push button pressed/released, USB and AC 
voltage status change. AM335x bone based boards (like BB, BBB, BBG) have 
common PMIC interrupt pin (named NMI) of AM335x core.

This patchset support interrupts in device tree file.

v2:
  Add missing a dt-binding header
  Use #defines instead of enum type for interrupt numbers

Milo Kim (8):
  ARM: dts: tps65217: Specify the interrupt controller
  ARM: dts: tps65217: Add the charger device
  ARM: dts: tps65217: Add the power button device
  ARM: dts: am335x: Support the PMIC interrupt
  dt-bindings: mfd: Provide human readable defines for TPS65217
    interrupts
  ARM: dts: am335x: Add the charger interrupt
  ARM: dts: am335x: Add the power button interrupt
  mfd: tps65217: Fix mismatched interrupt number

 arch/arm/boot/dts/am335x-bone-common.dtsi | 17 +++++++++++++++++
 arch/arm/boot/dts/tps65217.dtsi           | 12 ++++++++++++
 include/dt-bindings/mfd/tps65217.h        | 26 ++++++++++++++++++++++++++
 include/linux/mfd/tps65217.h              | 11 +++++------
 4 files changed, 60 insertions(+), 6 deletions(-)
 create mode 100644 include/dt-bindings/mfd/tps65217.h

-- 
2.9.3

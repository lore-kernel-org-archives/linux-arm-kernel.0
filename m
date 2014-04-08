From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Tue,  8 Apr 2014 16:00:40 +0800
Subject: [PATCH v2 00/12] Add Hisilicon HiP04 SoC
Message-ID: <1396944052-9887-1-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changelog:
v2:
  * Append ARCH_MULTI_V7_LPAE configuration. Define ARCH_MULTI_V7 to only
    support non-LPAE platform.
  * Append document of DT supporting.
  * Append ARCH_HISI in hi3xxx_defconfig.
  * Enable errata 798181 for HiP04 SoC.
  * Add PMU support.

Haojian Zhuang (10):
  ARM: debug: add HiP04 debug uart
  ARM: append ARCH_MULTI_V7_LPAE
  ARM: hisi: add ARCH_HISI
  irq: gic: use mask field in GICC_IAR
  irq: gic: extends the cpu interface to 16
  ARM: mcpm: change max clusters to 4
  ARM: hisi: add hip04 SoC support
  ARM: dts: add hip04-d01 dts file
  ARM: config: append hip04_defconfig
  ARM: config: select ARCH_HISI in hi3xxx_defconfig

Kefeng Wang (2):
  ARM: hisi: enable erratum 798181 of A15 on HiP04
  ARM: dts: Add PMU support in HiP04

 Documentation/devicetree/bindings/arm/gic.txt      |   1 +
 .../bindings/arm/hisilicon/hisilicon.txt           |  12 +
 .../devicetree/bindings/clock/hip04-clock.txt      |  20 ++
 arch/arm/Kconfig                                   |  11 +-
 arch/arm/Kconfig.debug                             |  10 +
 arch/arm/Makefile                                  |   2 +-
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/hip04-d01.dts                    |  74 ++++++
 arch/arm/boot/dts/hip04.dtsi                       | 260 +++++++++++++++++++++
 arch/arm/configs/hi3xxx_defconfig                  |   1 +
 arch/arm/configs/hip04_defconfig                   |  67 ++++++
 arch/arm/include/asm/mcpm.h                        |   2 +-
 arch/arm/mach-hisi/Kconfig                         |  24 +-
 arch/arm/mach-hisi/core.h                          |   6 +
 arch/arm/mach-hisi/hisilicon.c                     |  19 ++
 arch/arm/mach-hisi/platsmp.c                       | 259 ++++++++++++++++++++
 drivers/irqchip/irq-gic.c                          |  80 ++++---
 include/linux/irqchip/arm-gic.h                    |   2 +
 18 files changed, 813 insertions(+), 38 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/hip04-clock.txt
 create mode 100644 arch/arm/boot/dts/hip04-d01.dts
 create mode 100644 arch/arm/boot/dts/hip04.dtsi
 create mode 100644 arch/arm/configs/hip04_defconfig

-- 
1.8.3.2

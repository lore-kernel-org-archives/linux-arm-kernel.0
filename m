From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Mon, 28 Jul 2014 20:51:15 +0800
Subject: [PATCH v5 0/8] enable Hisilicon HIX5HD2 SoC
Message-ID: <1406551883-26154-1-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changelog:
v5:
  * Use CPU_OF_DECLARE_METHOD().
  * State "hisilicon,cpuctrl" in documents.
  * Set PL310 L2 aux value in machine descriptor.
  * Use enable-method property for smp in dts file.
  * Move reset code from machine platform driver into power reset driver.
  * Move HIP04 debug uart into another patch series.

v4:
  * Move CONFIG_ARCH_HISI from HiP04 SoC patch series to here.
  * Rename x5hd2. Always use HIX5HD2 or hix5hd2 instead.
  * Move HIP04 debug uart into this patch series.

v3:
  * Clean in headsmp.S.
  * Remove CONFIG_ARCH_HIX5HD2 in Makefile for headsmp.o. Use
    CONFIG_SMP instead.

v2:
  * Add document on DT binding.
  * Clean DTS file.
  * Avoid to parse DT binding in restart function.
  * Fix the hotplug issue.
  * Remove hardcoding in platsmp.

Haifeng Yan (3):
  ARM: debug: Rename Hi3716 to HI5XHD2
  ARM: hisi: enable hix5hd2 SoC
  ARM: dts: Add hix5hd2-dkb dts file.

Haojian Zhuang (5):
  ARM: hisi: add ARCH_HISI
  power: reset: move hisilicon reboot code
  ARM: config: enable ARCH_HIX5HD2
  ARM: hisi: set l2 aux for pl310
  ARM: hisi: remove smp from machine descriptor

 .../bindings/arm/hisilicon/hisilicon.txt           |  11 ++
 arch/arm/Kconfig.debug                             |  12 +-
 arch/arm/Makefile                                  |   2 +-
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/hi3620.dtsi                      |   1 +
 arch/arm/boot/dts/hix5hd2-dkb.dts                  |  53 +++++++
 arch/arm/boot/dts/hix5hd2.dtsi                     | 170 +++++++++++++++++++++
 arch/arm/configs/hi3xxx_defconfig                  |   2 +
 arch/arm/configs/multi_v7_defconfig                |   1 +
 arch/arm/mach-hisi/Kconfig                         |  30 +++-
 arch/arm/mach-hisi/Makefile                        |   2 +-
 arch/arm/mach-hisi/core.h                          |   5 +
 arch/arm/mach-hisi/headsmp.S                       |  16 ++
 arch/arm/mach-hisi/hisilicon.c                     |  47 ++----
 arch/arm/mach-hisi/hotplug.c                       |  58 +++++++
 arch/arm/mach-hisi/platsmp.c                       |  53 ++++++-
 drivers/power/reset/Kconfig                        |   6 +
 drivers/power/reset/Makefile                       |   1 +
 drivers/power/reset/hisi-reboot.c                  |  67 ++++++++
 19 files changed, 494 insertions(+), 44 deletions(-)
 create mode 100644 arch/arm/boot/dts/hix5hd2-dkb.dts
 create mode 100644 arch/arm/boot/dts/hix5hd2.dtsi
 create mode 100644 arch/arm/mach-hisi/headsmp.S
 create mode 100644 drivers/power/reset/hisi-reboot.c

-- 
1.9.1

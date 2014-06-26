From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Thu, 26 Jun 2014 12:05:39 +0800
Subject: [PATCH v4 0/8] enable hix5hd2 SoC
Message-ID: <1403755547-623-1-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changelog:
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
  ARM: hisi: store reboot reg in global variable
  ARM: debug: add HiP04 debug uart
  ARM: hisi: add ARCH_HISI
  ARM: config: add ARCH_HIX5HD2 in hi3xxx_defconfig
  document: add dt binding on hix5hd2 SoC

 .../bindings/arm/hisilicon/hisilicon.txt           |   9 ++
 arch/arm/Kconfig.debug                             |  22 ++-
 arch/arm/Makefile                                  |   2 +-
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/hix5hd2-dkb.dts                  |  52 +++++++
 arch/arm/boot/dts/hix5hd2.dtsi                     | 171 +++++++++++++++++++++
 arch/arm/configs/hi3xxx_defconfig                  |   2 +
 arch/arm/mach-hisi/Kconfig                         |  27 +++-
 arch/arm/mach-hisi/Makefile                        |   2 +-
 arch/arm/mach-hisi/core.h                          |   5 +
 arch/arm/mach-hisi/hisilicon.c                     |  32 +++-
 arch/arm/mach-hisi/hotplug.c                       |  58 +++++++
 arch/arm/mach-hisi/platsmp.c                       |  50 +++++-
 13 files changed, 412 insertions(+), 21 deletions(-)
 create mode 100644 arch/arm/boot/dts/hix5hd2-dkb.dts
 create mode 100644 arch/arm/boot/dts/hix5hd2.dtsi

-- 
1.9.1

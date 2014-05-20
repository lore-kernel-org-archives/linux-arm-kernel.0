From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Tue, 20 May 2014 22:36:59 +0800
Subject: [PATCH v3 0/6] enable Hix5hd2 SoC
Message-ID: <1400596625-16830-1-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changelog:
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

Haojian Zhuang (3):
  ARM: hisi: store reboot reg in global variable
  ARM: config: add ARCH_HIX5HD2 in hi3xxx_defconfig
  document: add dt binding on hix5hd2 SoC

 .../bindings/arm/hisilicon/hisilicon.txt           |   9 ++
 arch/arm/Kconfig.debug                             |  20 +--
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/hix5hd2-dkb.dts                  |  52 +++++++
 arch/arm/boot/dts/hix5hd2.dtsi                     | 171 +++++++++++++++++++++
 arch/arm/configs/hi3xxx_defconfig                  |   1 +
 arch/arm/mach-hisi/Kconfig                         |  13 +-
 arch/arm/mach-hisi/Makefile                        |   2 +-
 arch/arm/mach-hisi/core.h                          |   5 +
 arch/arm/mach-hisi/headsmp.S                       |  16 ++
 arch/arm/mach-hisi/hisilicon.c                     |  32 +++-
 arch/arm/mach-hisi/hotplug.c                       |  58 +++++++
 arch/arm/mach-hisi/platsmp.c                       |  50 +++++-
 13 files changed, 407 insertions(+), 23 deletions(-)
 create mode 100644 arch/arm/boot/dts/hix5hd2-dkb.dts
 create mode 100644 arch/arm/boot/dts/hix5hd2.dtsi
 create mode 100644 arch/arm/mach-hisi/headsmp.S

-- 
1.9.1

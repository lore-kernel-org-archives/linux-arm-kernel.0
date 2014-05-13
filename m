From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Tue, 13 May 2014 17:44:35 +0800
Subject: [PATCH v2 0/6] enable HiX5HD2 SoC
Message-ID: <1399974281-9737-1-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changelog:
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
 arch/arm/mach-hisi/Makefile                        |   1 +
 arch/arm/mach-hisi/core.h                          |   5 +
 arch/arm/mach-hisi/headsmp.S                       |  36 +++++
 arch/arm/mach-hisi/hisilicon.c                     |  34 +++-
 arch/arm/mach-hisi/hotplug.c                       |  58 +++++++
 arch/arm/mach-hisi/platsmp.c                       |  50 +++++-
 13 files changed, 429 insertions(+), 22 deletions(-)
 create mode 100644 arch/arm/boot/dts/hix5hd2-dkb.dts
 create mode 100644 arch/arm/boot/dts/hix5hd2.dtsi
 create mode 100644 arch/arm/mach-hisi/headsmp.S

-- 
1.9.1

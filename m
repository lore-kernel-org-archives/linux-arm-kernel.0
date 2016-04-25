From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Mon, 25 Apr 2016 09:49:12 +0100
Subject: [PATCH 0/5] Support MPS2 platform
Message-ID: <1461574157-23580-1-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

These patches add basic support for ARM Versatile Express Cortex-M
Prototyping System (V2M-MPS2). ucLinux can be now run on both the
hardware and FVP models with Cortex-M3/M4/M7 configurations

Following [1], please, consider to merge them into vexpress tree.

[1] https://lkml.org/lkml/2016/4/23/190

Thanks!

Vladimir Murzin (5):
  ARM: vexpress/mps2: introduce MPS2 platform
  ARM: configs: add MPS2 defconfig
  ARM: dts: introduce MPS2 AN385/AN386
  ARM: dts: introduce MPS2 AN399/AN400
  MAINTAINERS: Update ARM Versatile Express platform entry

 MAINTAINERS                          |    1 +
 arch/arm/Kconfig                     |   12 ++
 arch/arm/Makefile                    |    1 +
 arch/arm/boot/dts/Makefile           |    3 +
 arch/arm/boot/dts/mps2-an385.dts     |   92 +++++++++++++
 arch/arm/boot/dts/mps2-an399.dts     |   92 +++++++++++++
 arch/arm/boot/dts/mps2.dtsi          |  241 ++++++++++++++++++++++++++++++++++
 arch/arm/configs/mps2_defconfig      |  109 +++++++++++++++
 arch/arm/mach-vexpress/Makefile      |    4 +-
 arch/arm/mach-vexpress/Makefile.boot |    3 +
 arch/arm/mach-vexpress/v2m-mps2.c    |   21 +++
 11 files changed, 578 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/mps2-an385.dts
 create mode 100644 arch/arm/boot/dts/mps2-an399.dts
 create mode 100644 arch/arm/boot/dts/mps2.dtsi
 create mode 100644 arch/arm/configs/mps2_defconfig
 create mode 100644 arch/arm/mach-vexpress/Makefile.boot
 create mode 100644 arch/arm/mach-vexpress/v2m-mps2.c

-- 
1.7.9.5

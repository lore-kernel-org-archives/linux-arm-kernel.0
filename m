From: scott.shu@mediatek.com (Scott Shu)
Date: Fri, 19 Jun 2015 02:01:15 +0800
Subject: [RESEND PATCH 0/6] This series adds SMP support for the MediaTek
 MT6580.
In-Reply-To: <Scott Shu <srv_scott.shu@mediatek.com>
References: <Scott Shu <srv_scott.shu@mediatek.com>
Message-ID: <1434650481-39421-1-git-send-email-scott.shu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds support SMP on MediaTek MT6580 Cortex-A7 qual core SoC.

This is based on v4.1-rc1 and following patch series:
(1) Yingjoe Chen's "Add SMP bringup support for mt65xx socs" [1]
(2) Mars Cheng's "Add mt6580 basic chip support" [2]
(3) Sascha Hauer's "Mediatek SCPSYS power domain support" [3]

The secondary cores are power off as default on MT6580, this change adds
a new enable-method to turn on power to the cores during booting process.

The System Power Manager (SPM) inside the SCPSYS is for the CPU MTCMOS
power domain control. Please check [3] for more information about SCPSYS.

[1] https://lkml.org/lkml/2015/5/16/33
[2] https://lkml.org/lkml/2015/6/3/113
[3] https://lkml.org/lkml/2015/6/9/172


Scott Shu (6):
  Document: bindings: DT: Add SMP enable method for MT6580 SoC platform
  soc: Mediatek: Add SCPSYS CPU power domain driver
  ARM: mediatek: add smp bringup code
  ARM: Mediatek: enable GPT6 on boot up to make arch timer working for MT6580
  ARM: dts: mt6580: Add device nodes to the MT6580 dtsi file.
  ARM: dts: mt6580: enable basic SMP bringup for MT6580

 Documentation/devicetree/bindings/arm/cpus.txt |   1 +
 arch/arm/boot/dts/mt6580.dtsi                  |  25 +++
 arch/arm/mach-mediatek/Makefile                |   2 +-
 arch/arm/mach-mediatek/generic.h               |  24 +++
 arch/arm/mach-mediatek/hotplug.c               | 229 +++++++++++++++++++++++++
 arch/arm/mach-mediatek/mediatek.c              |   4 +-
 arch/arm/mach-mediatek/platsmp.c               | 113 +++++++++++-
 7 files changed, 395 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/mach-mediatek/generic.h
 create mode 100644 arch/arm/mach-mediatek/hotplug.c

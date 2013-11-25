From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Mon, 25 Nov 2013 11:07:40 +0800
Subject: [GIT PULL][for 3.14] pull request to enable Hisilicon SoC from pxa
 git tree
Message-ID: <5292BEFC.4080403@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof & Kevin,

Here's the pull request from pxa git tree to enable Hisilicon Hi3620 
SoC. Please help to merge.

Best Regards
Haojian

The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:

   Linux 3.13-rc1 (2013-11-22 11:30:55 -0800)

are available in the git repository at:

   http://git.kernel.org/pub/scm/linux/kernel/git/hzhuang1/linux.git 
tags/hisilicon-init

for you to fetch changes up to 24e76b00e43f2efcdfa8e32fc3bcf13f7fea1003:

   ARM: hi3xxx: add hotplug support (2013-11-25 11:02:33 +0800)

----------------------------------------------------------------
Enable Hisilicon Hi3620 SoC platform

----------------------------------------------------------------
Haojian Zhuang (4):
       ARM: hi3xxx: add board support with device tree
       ARM: dts: enable hi4511 with device tree
       ARM: config: enable hi3xxx in multi_v7_defconfig
       ARM: config: add defconfig for Hi3xxx

Zhangfei Gao (2):
       ARM: hi3xxx: add smp support
       ARM: hi3xxx: add hotplug support

  Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt |  32 ++++
  arch/arm/Kconfig                                              |   2 +
  arch/arm/Makefile                                             |   1 +
  arch/arm/boot/dts/Makefile                                    |   1 +
  arch/arm/boot/dts/hi3620.dtsi                                 | 556 
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  arch/arm/boot/dts/hi4511.dts                                  | 648 
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  arch/arm/configs/hi3xxx_defconfig                             |  56 
+++++++
  arch/arm/configs/multi_v7_defconfig                           |   1 +
  arch/arm/mach-hi3xxx/Kconfig                                  |  15 ++
  arch/arm/mach-hi3xxx/Makefile                                 |   7 +
  arch/arm/mach-hi3xxx/core.h                                   |  15 ++
  arch/arm/mach-hi3xxx/hi3xxx.c                                 |  94 
++++++++++++
  arch/arm/mach-hi3xxx/hotplug.c                                | 200 
+++++++++++++++++++++++++
  arch/arm/mach-hi3xxx/platsmp.c                                |  89 
+++++++++++
  14 files changed, 1717 insertions(+)
  create mode 100644 
Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
  create mode 100644 arch/arm/boot/dts/hi3620.dtsi
  create mode 100644 arch/arm/boot/dts/hi4511.dts
  create mode 100644 arch/arm/configs/hi3xxx_defconfig
  create mode 100644 arch/arm/mach-hi3xxx/Kconfig
  create mode 100644 arch/arm/mach-hi3xxx/Makefile
  create mode 100644 arch/arm/mach-hi3xxx/core.h
  create mode 100644 arch/arm/mach-hi3xxx/hi3xxx.c
  create mode 100644 arch/arm/mach-hi3xxx/hotplug.c
  create mode 100644 arch/arm/mach-hi3xxx/platsmp.c

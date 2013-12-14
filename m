From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Sat, 14 Dec 2013 15:44:01 +0800
Subject: [GIT PULL v4][for 3.14] pull request for hisilicon soc
Message-ID: <52AC0C41.2040607@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof/Kevin,

Now I fix the wrong pull request. Here's the updated for hisilicon soc. 
Please help to merge it.

    Changes from v2 is in below. Since v3 is wrong, let's drop it.
     1. Update the git repository address from ssh:// to git://.
     2. Add clock binding in DTS file. This patch is contained in v11
& v12 patch sets, and everybody like this binding.
     3. Add the GPIOLIB selection by default.

Best Regards
Haojian

The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:

   Linux 3.13-rc1 (2013-11-22 11:30:55 -0800)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/hzhuang1/linux.git 
tags/hisilicon-basic

for you to fetch changes up to 1c8c50932ee54c83fc34ea140bc91bc2913d7132:

   ARM: hi3xxx: select GPIO in Kconfig (2013-12-12 09:10:00 +0800)

----------------------------------------------------------------
Haojian Zhuang (6):
       ARM: hi3xxx: add board support with device tree
       ARM: dts: enable hi4511 with device tree
       ARM: config: enable hi3xxx in multi_v7_defconfig
       ARM: config: add defconfig for Hi3xxx
       ARM: dts: enable clock binding on Hi3620
       ARM: hi3xxx: select GPIO in Kconfig

Zhangfei Gao (2):
       ARM: hi3xxx: add smp support
       ARM: hi3xxx: add hotplug support

  .../bindings/arm/hisilicon/hisilicon.txt           |  32 +
  arch/arm/Kconfig                                   |   2 +
  arch/arm/Makefile                                  |   1 +
  arch/arm/boot/dts/Makefile                         |   1 +
  arch/arm/boot/dts/hi3620.dtsi                      | 565 
++++++++++++++++++
  arch/arm/boot/dts/hi4511.dts                       | 649 
+++++++++++++++++++++
  arch/arm/configs/hi3xxx_defconfig                  |  56 ++
  arch/arm/configs/multi_v7_defconfig                |   1 +
  arch/arm/mach-hi3xxx/Kconfig                       |  17 +
  arch/arm/mach-hi3xxx/Makefile                      |   7 +
  arch/arm/mach-hi3xxx/core.h                        |  15 +
  arch/arm/mach-hi3xxx/hi3xxx.c                      |  97 +++
  arch/arm/mach-hi3xxx/hotplug.c                     | 200 +++++++
  arch/arm/mach-hi3xxx/platsmp.c                     |  89 +++
  14 files changed, 1732 insertions(+)
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

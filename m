From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Wed, 28 Aug 2013 21:18:38 +0800
Subject: [GIT PULL for v3.12] pull request from pxa git tree for hi3xxx
Message-ID: <CAD6h2NSz6yroFd2Uxt+0DUSc7yyc68caWm6P6RdaxshiR2MCmA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Please help to merge hi3xxx tag from pxa git tree. It's used to enable
Hi3xxx SoC.

The debug ll patch isn't included in this patch set since it's going
through Russell's tree.

The clock patch isn't included also. Since it's going through Mike's clock tree.

Best Regards
Haojian

The following changes since commit ad81f0545ef01ea651886dddac4bef6cec930092:

  Linux 3.11-rc1 (2013-07-14 15:18:27 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/hzhuang1/linux.git tags/hi3xxx

for you to fetch changes up to b2a7fa761f9f1f60ccb7ba2acd4c8dd5f71be7a8:

  ARM: hi3xxx: add hotplug support (2013-08-28 21:13:11 +0800)

----------------------------------------------------------------
enable Hi3xxx SoC

----------------------------------------------------------------
Haojian Zhuang (4):
      ARM: hi3xxx: add board support with device tree
      ARM: dts: enable hi4511 with device tree
      ARM: config: enable hi3xxx in multi_v7_defconfig
      ARM: config: add defconfig for Hi3xxx

Zhangfei Gao (2):
      ARM: hi3xxx: add smp support
      ARM: hi3xxx: add hotplug support

 Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt |   60 +++++
 arch/arm/Kconfig                                              |    2 +
 arch/arm/Makefile                                             |    1 +
 arch/arm/boot/dts/Makefile                                    |    1 +
 arch/arm/boot/dts/hi3620-clk.dtsi                             | 1062
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/hi3620.dtsi                                 |  540
++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/hi4511.dts                                  |  648
++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/configs/hi3xxx_defconfig                             |   56 +++++
 arch/arm/configs/multi_v7_defconfig                           |    1 +
 arch/arm/mach-hi3xxx/Kconfig                                  |   14 ++
 arch/arm/mach-hi3xxx/Makefile                                 |    7 +
 arch/arm/mach-hi3xxx/core.h                                   |   18 ++
 arch/arm/mach-hi3xxx/hi3xxx.c                                 |   42 ++++
 arch/arm/mach-hi3xxx/hotplug.c                                |  168
+++++++++++++
 arch/arm/mach-hi3xxx/platsmp.c                                |   48 ++++
 arch/arm/mach-hi3xxx/system.c                                 |   64 +++++
 16 files changed, 2732 insertions(+)
 create mode 100644
Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
 create mode 100644 arch/arm/boot/dts/hi3620-clk.dtsi
 create mode 100644 arch/arm/boot/dts/hi3620.dtsi
 create mode 100644 arch/arm/boot/dts/hi4511.dts
 create mode 100644 arch/arm/configs/hi3xxx_defconfig
 create mode 100644 arch/arm/mach-hi3xxx/Kconfig
 create mode 100644 arch/arm/mach-hi3xxx/Makefile
 create mode 100644 arch/arm/mach-hi3xxx/core.h
 create mode 100644 arch/arm/mach-hi3xxx/hi3xxx.c
 create mode 100644 arch/arm/mach-hi3xxx/hotplug.c
 create mode 100644 arch/arm/mach-hi3xxx/platsmp.c
 create mode 100644 arch/arm/mach-hi3xxx/system.c

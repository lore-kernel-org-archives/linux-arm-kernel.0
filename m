From: xuejiancheng@huawei.com (Jiancheng Xue)
Date: Thu, 3 Dec 2015 10:29:14 +0800
Subject: [PATCH v2 0/9] ARM: hisi: enable hi3519 soc
Message-ID: <1449109754-23309-1-git-send-email-xuejiancheng@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Hi3519 soc is mainly used for ip camera and sport DV solutions. This patchset adds initial support
for Hi3519 soc. It includes clock driver, arch configuration, device tree and debug uart configuration.
It has been tested on hi3519 reference board.

Spi-nor flash driver and other peripheral drivers will be submitted later.

Any comments will be appreciated!

Thanks!

Change Log
----------
v2:
-Rebase to v4.4-rc3
-Put dt-binding doc and header file in a separate patch.
-Delete unused clocks definitions.
-Adjust the ARCH_xxx order in Kconfig file
-Rename ARCH_HI3xxx to ARCH_36xx

Jiancheng Xue (9):
  clk: hi3519: add dt-binding document and header file
  clk: hi3519: add CRG driver for hisilicon hi3519 soc
  ARM: hisi: enable Hi3519 soc
  ARM: dts: add dts files for hi3519-demb board
  ARM: config: enable ARCH_HI3519
  ARM: debug: add Hi3519 debug uart
  ARM: hisi: rename ARCH_HI3xxx to ARCH_HI36xx
  clk: hisilicon: rename ARCH_HI3xxx to ARCH_HI36xx
  dmaengine: Kconfig: rename ARCH_HI3xxx to ARCH_HI36xx

 .../devicetree/bindings/clock/hi3519-crg.txt       |  46 +++++++
 arch/arm/Kconfig.debug                             |  14 +-
 arch/arm/boot/dts/Makefile                         |   4 +-
 arch/arm/boot/dts/hi3519-demb.dts                  |  55 ++++++++
 arch/arm/boot/dts/hi3519.dtsi                      | 129 ++++++++++++++++++
 arch/arm/configs/hisi_defconfig                    |   3 +-
 arch/arm/configs/multi_v7_defconfig                |   2 +-
 arch/arm/mach-hisi/Kconfig                         |  11 +-
 arch/arm/mach-hisi/hisilicon.c                     |   9 ++
 drivers/clk/hisilicon/Makefile                     |   3 +-
 drivers/clk/hisilicon/clk-hi3519.c                 | 100 ++++++++++++++
 drivers/clk/hisilicon/reset.c                      | 149 +++++++++++++++++++++
 drivers/clk/hisilicon/reset.h                      |  25 ++++
 drivers/dma/Kconfig                                |   2 +-
 include/dt-bindings/clock/hi3519-clock.h           |  51 +++++++
 15 files changed, 595 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/hi3519-crg.txt
 create mode 100644 arch/arm/boot/dts/hi3519-demb.dts
 create mode 100644 arch/arm/boot/dts/hi3519.dtsi
 create mode 100644 drivers/clk/hisilicon/clk-hi3519.c
 create mode 100644 drivers/clk/hisilicon/reset.c
 create mode 100644 drivers/clk/hisilicon/reset.h
 create mode 100644 include/dt-bindings/clock/hi3519-clock.h

-- 
1.9.1

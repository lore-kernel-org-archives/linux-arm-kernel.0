From: xuejiancheng@huawei.com (Jiancheng Xue)
Date: Sat, 28 Nov 2015 15:01:16 +0800
Subject: [PATCH 0/5] arm, hisi: enable Hi3519 soc
Message-ID: <1448694076-31141-1-git-send-email-xuejiancheng@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Hi3519 soc is mainly used for ip camera and sport DV solutions. This patchset adds initial support
for Hi3519 soc. It includes clock driver, arch configuration, device tree and debug uart configuration.
It has been tested on hi3519 reference board.

Spi-nor flash driver and other peripheral drivers will be submitted later.

Any comments will be appreciated!

Thanks!

Jiancheng Xue (5):
  clk: hi3519: add CRG driver for hisilicon hi3519 soc
  ARM: hisi: enable Hi3519 soc
  ARM: dts: add dts files for hi3519-demb board
  ARM: config: enable ARCH_HI3519
  ARM: debug: add Hi3519 debug uart

 .../devicetree/bindings/clock/hi3519-clock.txt     |  46 +++++++
 arch/arm/Kconfig.debug                             |  10 ++
 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/hi3519-demb.dts                  |  55 ++++++++
 arch/arm/boot/dts/hi3519.dtsi                      | 129 ++++++++++++++++++
 arch/arm/configs/hisi_defconfig                    |   1 +
 arch/arm/mach-hisi/Kconfig                         |   9 ++
 arch/arm/mach-hisi/hisilicon.c                     |   9 ++
 drivers/clk/hisilicon/Makefile                     |   1 +
 drivers/clk/hisilicon/clk-hi3519.c                 | 130 ++++++++++++++++++
 drivers/clk/hisilicon/reset.c                      | 149 +++++++++++++++++++++
 drivers/clk/hisilicon/reset.h                      |  25 ++++
 include/dt-bindings/clock/hi3519-clock.h           |  78 +++++++++++
 13 files changed, 644 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/hi3519-clock.txt
 create mode 100644 arch/arm/boot/dts/hi3519-demb.dts
 create mode 100644 arch/arm/boot/dts/hi3519.dtsi
 create mode 100644 drivers/clk/hisilicon/clk-hi3519.c
 create mode 100644 drivers/clk/hisilicon/reset.c
 create mode 100644 drivers/clk/hisilicon/reset.h
 create mode 100644 include/dt-bindings/clock/hi3519-clock.h

-- 
1.9.1

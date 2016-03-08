From: xuejiancheng@huawei.com (Jiancheng Xue)
Date: Tue, 8 Mar 2016 10:20:12 +0800
Subject: [PATCH v10 0/6] ARM: hisi: Add initial support including clock driver
 for Hi3519 soc.
Message-ID: <1457403618-18317-1-git-send-email-xuejiancheng@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Hi3519 soc is mainly used for ip camera and sport DV solutions. This patchset adds initial support
for Hi3519 soc. It includes clock driver, arch configuration, debug uart configuration and device tree.
It has been tested on hi3519 reference board.

Any comments will be appreciated!

Thanks!

Change Log
----------
v10:
--Fixed issues pointed by Stephen Boyd.

v9:
--Fixed issues pointed by Michael Turquette.

v8:
--Made hi3519 clock driver can be compiled as a module
--Fixed an issue in arch/arm/Kconfig.debug

v7:
--Rebased to v4.5-rc1

v6:
-Changed clock driver to a real platform driver

v5:
-Adjusted clock and reset controller driver code

v4:
-Rebased to v4.4-rc7
-Divided patches according to Rob's comments
-Added spi nodes in hi3519-demb.dts

v3:
-Rebased to v4.4-rc4
-Adjusted according to Arnd's comments
-Removed ARCH_HI3519, using ARCH_HISI directly

v2:
-Rebased to v4.4-rc3
-Put dt-binding doc and header file in a separate patch.
-Deleted unused clocks definitions.
-Adjusted the ARCH_xxx order in Kconfig file
-Renamed ARCH_HI3xxx to ARCH_36xx

Jiancheng Xue (6):
  clk: hisilicon: export some hisilicon APIs to modules
  clk: hisilicon: add CRG driver for hi3519 soc
  ARM: hisi: add compatible string for Hi3519 soc
  ARM: debug: add hi3519 debug uart
  ARM: dt-bindings: add device tree bindings for Hi3519 sysctrl
  ARM: dts: add dts files for Hi3519

 .../bindings/arm/hisilicon/hi3519-sysctrl.txt      |  14 ++
 .../devicetree/bindings/clock/hi3519-crg.txt       |  46 +++++
 arch/arm/Kconfig.debug                             |  10 ++
 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/hi3519-demb.dts                  |  42 +++++
 arch/arm/boot/dts/hi3519.dtsi                      | 187 +++++++++++++++++++++
 arch/arm/mach-hisi/hisilicon.c                     |  23 +--
 drivers/clk/hisilicon/Kconfig                      |  15 ++
 drivers/clk/hisilicon/Makefile                     |   2 +
 drivers/clk/hisilicon/clk-hi3519.c                 | 129 ++++++++++++++
 drivers/clk/hisilicon/clk.c                        |  23 ++-
 drivers/clk/hisilicon/clk.h                        |  14 +-
 drivers/clk/hisilicon/reset.c                      | 124 ++++++++++++++
 drivers/clk/hisilicon/reset.h                      |  32 ++++
 include/dt-bindings/clock/hi3519-clock.h           |  40 +++++
 15 files changed, 669 insertions(+), 34 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/hi3519-sysctrl.txt
 create mode 100644 Documentation/devicetree/bindings/clock/hi3519-crg.txt
 create mode 100644 arch/arm/boot/dts/hi3519-demb.dts
 create mode 100644 arch/arm/boot/dts/hi3519.dtsi
 create mode 100644 drivers/clk/hisilicon/clk-hi3519.c
 create mode 100644 drivers/clk/hisilicon/reset.c
 create mode 100644 drivers/clk/hisilicon/reset.h
 create mode 100644 include/dt-bindings/clock/hi3519-clock.h

-- 
1.9.1

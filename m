From: xuejiancheng@huawei.com (Jiancheng Xue)
Date: Fri, 29 Jan 2016 15:42:06 +0800
Subject: [PATCH v8 0/6] ARM: hisi: Add initial support including clock driver
 for Hi3519 soc.
Message-ID: <1454053332-3218-1-git-send-email-xuejiancheng@huawei.com>
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
v8:
--Made hi3519 clock driver can be compiled as a module
--Fixed an issue in arch/arm/Kconfig.debug

v7:
--Rebase to v4.5-rc1

v6:
-Change clock driver to a real platform driver

v5:
-Adjust clock and reset controller driver code

v4:
-Rebase to v4.4-rc7
-Divide patches according to Rob's comments
-Add spi nodes in hi3519-demb.dts

v3:
-Rebase to v4.4-rc4
-Adjust according to Arnd's comments
-Remove ARCH_HI3519, using ARCH_HISI directly

v2:
-Rebase to v4.4-rc3
-Put dt-binding doc and header file in a separate patch.
-Delete unused clocks definitions.
-Adjust the ARCH_xxx order in Kconfig file
-Rename ARCH_HI3xxx to ARCH_36xx

Jiancheng Xue (6):
  clk: hisilicon: add CRG driver for hi3519 soc
  ARM: hisi: add compatible string for Hi3519 soc
  ARM: config: hisi: enable CONFIG_RESET_CONTROLLER
  ARM: debug: add hi3519 debug uart
  ARM: dt-bindings: add device tree bindings for Hi3519 sysctrl
  ARM: dts: add dts files for Hi3519

 .../bindings/arm/hisilicon/hi3519-sysctrl.txt      |  14 ++
 .../devicetree/bindings/clock/hi3519-crg.txt       |  46 +++++
 arch/arm/Kconfig.debug                             |  10 ++
 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/hi3519-demb.dts                  |  42 +++++
 arch/arm/boot/dts/hi3519.dtsi                      | 187 +++++++++++++++++++++
 arch/arm/configs/hisi_defconfig                    |   1 +
 arch/arm/mach-hisi/hisilicon.c                     |  23 +--
 drivers/clk/hisilicon/Kconfig                      |   7 +
 drivers/clk/hisilicon/Makefile                     |   2 +
 drivers/clk/hisilicon/clk-hi3519.c                 | 133 +++++++++++++++
 drivers/clk/hisilicon/clk.c                        |  23 ++-
 drivers/clk/hisilicon/clk.h                        |  14 +-
 drivers/clk/hisilicon/reset.c                      | 130 ++++++++++++++
 drivers/clk/hisilicon/reset.h                      |  32 ++++
 include/dt-bindings/clock/hi3519-clock.h           |  40 +++++
 16 files changed, 672 insertions(+), 34 deletions(-)
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

From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Tue, 31 Jul 2012 09:42:38 +0800
Subject: [GIT PULL] [for 3.6] pull request from dt-pxa branch in pxa git tree
Message-ID: <CAN1soZxFsnhEnyn3=2PtCovfpWeD6Kb=z5eEGAjdEO+9qUTQfQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd & Olof,

Please help to pull changes from dt-pxa branch in pxa git tree.

Regards
Haojian

The following changes since commit 28a33cbc24e4256c143dce96c7d93bf423229f92:

  Linux 3.5 (2012-07-21 13:58:29 -0700)

are available in the git repository at:

  git://github.com/hzhuang1/linux.git dt-pxa

for you to fetch changes up to 98d0e7160c9ebd0caf61aac13fb5b63c53de9a59:

  ARM: dts: add pinctrl in PXA DT files (2012-07-31 09:24:53 +0800)

----------------------------------------------------------------
Daniel Mack (9):
      RTC: add DT bindings to pxa-rtc
      MMC: pxa-mci: add DT bindings
      MTD: pxa3xx-nand: add devicetree bindings
      GPIO: gpio-pxa: simplify pxa_gpio_to_irq() and pxa_irq_to_chip()
      GPIO: gpio-pxa: fix devicetree functions
      ARM: pxa: add devicetree code for irq handling
      ARM: pxa3xx: skip default device initialization when booting via DT
      ARM: pxa3xx: add generic DT machine code
      ARM: pxa: add .dtsi files

Haojian Zhuang (6):
      pinctrl: append new pins and groups in pxa910
      pinctrl: add pinconf support in pxa3xx
      pinctrl: support dt in pxa series
      pinctrl: append new groups of mmp2
      ARM: mmp: select pinctrl for boards with DT
      ARM: dts: add pinctrl in PXA DT files

 Documentation/devicetree/bindings/mmc/pxa-mmc.txt  |   25 ++
 .../devicetree/bindings/mtd/pxa3xx-nand.txt        |   31 ++
 .../bindings/pinctrl/mrvl,pxa3xx-pinctrl.txt       |   35 +++
 Documentation/devicetree/bindings/rtc/pxa-rtc.txt  |   14 +
 arch/arm/boot/dts/mmp2-brownstone.dts              |   51 +++
 arch/arm/boot/dts/mmp2.dtsi                        |    5 +
 arch/arm/boot/dts/pxa168.dtsi                      |    5 +
 arch/arm/boot/dts/pxa27x.dtsi                      |   14 +
 arch/arm/boot/dts/pxa2xx.dtsi                      |  132 ++++++++
 arch/arm/boot/dts/pxa3xx.dtsi                      |   32 ++
 arch/arm/boot/dts/pxa910-dkb.dts                   |   47 +++
 arch/arm/boot/dts/pxa910.dtsi                      |    5 +
 arch/arm/mach-mmp/Kconfig                          |    2 +
 arch/arm/mach-pxa/Kconfig                          |   12 +
 arch/arm/mach-pxa/Makefile                         |    3 +
 arch/arm/mach-pxa/irq.c                            |  131 ++++++--
 arch/arm/mach-pxa/pxa-dt.c                         |   63 ++++
 arch/arm/mach-pxa/pxa3xx.c                         |   21 +-
 drivers/gpio/gpio-pxa.c                            |   96 +++---
 drivers/mmc/host/pxamci.c                          |   52 ++++
 drivers/mtd/nand/pxa3xx_nand.c                     |   85 ++++-
 drivers/pinctrl/pinctrl-mmp2.c                     |   18 +-
 drivers/pinctrl/pinctrl-pxa168.c                   |   10 +-
 drivers/pinctrl/pinctrl-pxa3xx.c                   |  325 ++++++++++++++++++++
 drivers/pinctrl/pinctrl-pxa3xx.h                   |   17 +
 drivers/pinctrl/pinctrl-pxa910.c                   |   16 +-
 drivers/rtc/rtc-pxa.c                              |   11 +
 27 files changed, 1160 insertions(+), 98 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/pxa-mmc.txt
 create mode 100644 Documentation/devicetree/bindings/mtd/pxa3xx-nand.txt
 create mode 100644
Documentation/devicetree/bindings/pinctrl/mrvl,pxa3xx-pinctrl.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/pxa-rtc.txt
 create mode 100644 arch/arm/boot/dts/pxa27x.dtsi
 create mode 100644 arch/arm/boot/dts/pxa2xx.dtsi
 create mode 100644 arch/arm/boot/dts/pxa3xx.dtsi
 create mode 100644 arch/arm/mach-pxa/pxa-dt.c

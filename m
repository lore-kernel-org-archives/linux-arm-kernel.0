From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Fri, 3 Aug 2012 14:53:18 +0800
Subject: [GIT PULL][for 3.7] pull request from dt-mmp branch in pxa git tree
Message-ID: <CAN1soZy-FBmywNLn9a0yanx9ojfB-jnqzYyXwAYr6F1_Khvacg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof & Arnd,

Please help to merge these patches from dt-mmp branch in pxa git tree.

Regards
Haojian

The following changes since commit 0d7614f09c1ebdbaa1599a5aba7593f147bf96ee:

  Linux 3.6-rc1 (2012-08-02 16:38:10 -0700)

are available in the git repository at:

  git://github.com/hzhuang1/linux.git dt-mmp

for you to fetch changes up to c807e2a01b45aa921bb6e3bf68bf135fddaa538c:

  ARM: dts: add pinctrl in PXA DT files (2012-08-03 14:43:05 +0800)

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

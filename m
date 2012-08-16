From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Thu, 16 Aug 2012 16:44:15 +0800
Subject: [GIT PULL][for 3.7] pull request from dt branch in pxa git tree
Message-ID: <CAN1soZwJMbr-9T-7qhh_qfmfjJ+WmTstkhFmZ=yewoJxs+MGqA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof & Arnd,

Please help to merge these patches from dt branch in pxa git tree.

It's the V4 version. The changes are in below.

v4:
1. remove pinctrl patches for pxa.

v3:
1. Revert d03c1990c9681047bf94caa497c41172b3f28351 GPIO: gpio-pxa: fix
devicetree functions
since it's merged into Linus' gpio tree.

v2:
1. Add Linus's Ack in pinctrl driver.
2. Add chao's & haojian's patches for Tauros2 cache.

The following changes since commit 0d7614f09c1ebdbaa1599a5aba7593f147bf96ee:

  Linux 3.6-rc1 (2012-08-02 16:38:10 -0700)

are available in the git repository at:

  git://github.com/hzhuang1/linux.git dt

for you to fetch changes up to 51931b37fcb17a2f48f726fd21b88e3af770ddc2:

  ARM: mmp: enable tauros2 cache in mmp2 dt (2012-08-16 16:17:10 +0800)

----------------------------------------------------------------
Chao Xie (7):
      ARM: pxa: support CKENC in clk_enable
      gpio: pxa: add chain_eneter and chain_exit for irq handler
      ARM: cache: fix uninitialized ptr in tauros2_init
      ARM: cache: add cputype.h for tauros2
      ARM: cache: add extra feature enable for tauros2
      ARM: mmp&dove: modify tauros2_init call
      ARM: cache: add dt support for tauros2 cache

Daniel Mack (7):
      RTC: add DT bindings to pxa-rtc
      MTD: pxa3xx-nand: add devicetree bindings
      GPIO: gpio-pxa: simplify pxa_gpio_to_irq() and pxa_irq_to_chip()
      ARM: pxa: add devicetree code for irq handling
      ARM: pxa3xx: skip default device initialization when booting via DT
      ARM: pxa3xx: add generic DT machine code
      ARM: pxa: add .dtsi files

Haojian Zhuang (2):
      ARM: mmp: enable tauros2 cache in pxa910
      ARM: mmp: enable tauros2 cache in mmp2 dt

 .../devicetree/bindings/arm/mrvl/tauros2.txt       |   17 +++
 .../devicetree/bindings/mtd/pxa3xx-nand.txt        |   31 +++++
 Documentation/devicetree/bindings/rtc/pxa-rtc.txt  |   14 +++
 arch/arm/boot/dts/mmp2.dtsi                        |    5 +
 arch/arm/boot/dts/pxa27x.dtsi                      |   14 +++
 arch/arm/boot/dts/pxa2xx.dtsi                      |  132 ++++++++++++++++++++
 arch/arm/boot/dts/pxa3xx.dtsi                      |   32 +++++
 arch/arm/boot/dts/pxa910.dtsi                      |    5 +
 arch/arm/include/asm/hardware/cache-tauros2.h      |    5 +-
 arch/arm/mach-dove/common.c                        |    2 +-
 arch/arm/mach-mmp/mmp2.c                           |    2 +-
 arch/arm/mach-mmp/pxa910.c                         |    4 +
 arch/arm/mach-pxa/Kconfig                          |   12 ++
 arch/arm/mach-pxa/Makefile                         |    3 +
 arch/arm/mach-pxa/clock-pxa3xx.c                   |    8 +-
 arch/arm/mach-pxa/irq.c                            |  131 +++++++++++++++----
 arch/arm/mach-pxa/pxa-dt.c                         |   63 ++++++++++
 arch/arm/mach-pxa/pxa3xx.c                         |   21 +++-
 arch/arm/mm/cache-tauros2.c                        |   83 ++++++++----
 drivers/gpio/gpio-pxa.c                            |   77 ++++--------
 drivers/mtd/nand/pxa3xx_nand.c                     |   85 ++++++++++---
 drivers/rtc/rtc-pxa.c                              |   11 ++
 22 files changed, 639 insertions(+), 118 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/mrvl/tauros2.txt
 create mode 100644 Documentation/devicetree/bindings/mtd/pxa3xx-nand.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/pxa-rtc.txt
 create mode 100644 arch/arm/boot/dts/pxa27x.dtsi
 create mode 100644 arch/arm/boot/dts/pxa2xx.dtsi
 create mode 100644 arch/arm/boot/dts/pxa3xx.dtsi
 create mode 100644 arch/arm/mach-pxa/pxa-dt.c

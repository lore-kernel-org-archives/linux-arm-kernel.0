From: zonque@gmail.com (Daniel Mack)
Date: Thu, 26 Jul 2012 21:16:20 +0200
Subject: [PATCH v2 0/7] Assorted PXA3xx DT patches
Message-ID: <1343330187-20049-1-git-send-email-zonque@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a series of 7 patches that add basic support for booting PXA3xx
boards from devicetrees. I'm able to mount a rootfs and use all
irq/gpio based functions as well as the NAND, USB and RTC drivers.

Changes from the first version include

 - renaming of "mrvl" to "marvell"
 - better documentation

Thanks to everyone who provided feedback.


Daniel Mack (7):
  RTC: add DT bindings to pxa-rtc
  MMC: pxa-mci: add DT bindings
  MTD: pxa3xx-nand: add devicetree bindings
  ARM: pxa: add devicetree code for irq handling
  ARM: pxa3xx: skip default device initialization when booting via DT
  ARM: pxa3xx: add generic DT machine code
  ARM: pxa: add .dtsi files

 Documentation/devicetree/bindings/mmc/pxa-mmc.txt  |  25 ++++
 .../devicetree/bindings/mtd/pxa3xx-nand.txt        |  31 +++++
 Documentation/devicetree/bindings/rtc/pxa-rtc.txt  |  14 +++
 arch/arm/boot/dts/pxa2xx.dtsi                      | 132 +++++++++++++++++++++
 arch/arm/boot/dts/pxa3xx.dtsi                      |  27 +++++
 arch/arm/mach-pxa/Kconfig                          |  12 ++
 arch/arm/mach-pxa/Makefile                         |   3 +
 arch/arm/mach-pxa/irq.c                            |  73 ++++++++++++
 arch/arm/mach-pxa/pxa-dt.c                         |  63 ++++++++++
 arch/arm/mach-pxa/pxa3xx.c                         |  21 +++-
 drivers/mmc/host/pxamci.c                          |  52 ++++++++
 drivers/mtd/nand/pxa3xx_nand.c                     |  85 ++++++++++---
 drivers/rtc/rtc-pxa.c                              |  11 ++
 13 files changed, 532 insertions(+), 17 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/pxa-mmc.txt
 create mode 100644 Documentation/devicetree/bindings/mtd/pxa3xx-nand.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/pxa-rtc.txt
 create mode 100644 arch/arm/boot/dts/pxa2xx.dtsi
 create mode 100644 arch/arm/boot/dts/pxa3xx.dtsi
 create mode 100644 arch/arm/mach-pxa/pxa-dt.c

-- 
1.7.11.2

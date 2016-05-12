From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Thu, 12 May 2016 12:38:48 +0000
Subject: [PATCH 0/4] add minimal bcm2835-sdram driver
Message-ID: <1463056732-5607-1-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

As the sdram clock is a critical clock to the system
the minimal bcm2835-sdram driver claims (and enables)
this clock and also exposes the corresponding sdram
registers via debugfs.

Martin Sperl (4):
  dt: bindings: add bcm2835-memory-controller documentation
  memory: bcm2835: add bcm2835-memory controller
  ARM: dts: bcm2835: add the bcm2835-sdram-controller to the dt
  ARM: bcm2835_defconfig: add bcm2835-sdram controller

 .../memory-controllers/brcm,bcm2835-sdram.txt      |  16 +++
 arch/arm/boot/dts/bcm283x.dtsi                     |   6 +
 arch/arm/configs/bcm2835_defconfig                 |   1 +
 drivers/memory/Kconfig                             |   7 +
 drivers/memory/Makefile                            |   1 +
 drivers/memory/bcm2835-sdram.c                     | 152 +++++++++++++++++++++
 6 files changed, 183 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/brcm,bcm2835-sdram.txt
 create mode 100644 drivers/memory/bcm2835-sdram.c

--
2.1.4

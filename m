From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Fri, 11 Sep 2015 11:22:02 +0000
Subject: [PATCH v6 0/4] spi: bcm2835: add spi-bcm2835aux driver
Message-ID: <1441970527-2403-1-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

This patch-series adds the spi-bcm2835aux driver to the kernel.

After a long discussion of how to enable/disable the hw block,
which resulted in multiple versions, the consensus is now
that the clk-bcm2835-aux clock driver is responsible for
enabling/disabling the HW block.

So there is a dependency of this device-driver on the
clock driver that supplies that functionality.

Martin Sperl (4):
  dt/bindings: bcm2835: spi: add bindings for the bcm2835 auxiliary spi
    devices
  spi: bcm2835: add bcm2835 auxiliary spi device driver
  spi: bcm2835: add the auxiliary spi1 and spi2 to the device tree
  ARM: bcm2835: enable auxiliary spi driver in defaultconfig

 .../bindings/spi/brcm,bcm2835-aux-spi.txt          |   38 ++
 arch/arm/boot/dts/bcm2835.dtsi                     |   21 +
 arch/arm/configs/bcm2835_defconfig                 |    1 +
 drivers/spi/Kconfig                                |   11 +
 drivers/spi/Makefile                               |    1 +
 drivers/spi/spi-bcm2835aux.c                       |  493 ++++++++++++++++++++
 6 files changed, 565 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/brcm,bcm2835-aux-spi.txt
 create mode 100644 drivers/spi/spi-bcm2835aux.c

--
1.7.10.4

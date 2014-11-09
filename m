From: b.galvani@gmail.com (Beniamino Galvani)
Date: Sun,  9 Nov 2014 10:25:10 +0100
Subject: [PATCH 0/3] spi: Add support for Amlogic Meson SPIFC
Message-ID: <1415525113-25598-1-git-send-email-b.galvani@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this patchset adds a driver for the SPIFC (SPI flash controller)
available in Amlogic Meson6 and Meson8 SoCs. It doesn't support DMA
and has a 64-byte unified transmit/receive buffer.

The driver has been tested on a Meson8 based device to communicate
with a Macronix mx25l1606e serial flash.

Beniamino Galvani (3):
  spi: meson: Add device tree bindings documentation for SPIFC
  spi: meson: Add support for Amlogic Meson SPIFC
  ARM: dts: meson: add node for SPIFC

 .../devicetree/bindings/spi/spi-meson.txt          |  22 ++
 arch/arm/boot/dts/meson.dtsi                       |   9 +
 drivers/spi/Kconfig                                |   7 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-meson-spifc.c                      | 411 +++++++++++++++++++++
 5 files changed, 450 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-meson.txt
 create mode 100644 drivers/spi/spi-meson-spifc.c

-- 
1.9.1

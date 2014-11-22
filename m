From: b.galvani@gmail.com (Beniamino Galvani)
Date: Sat, 22 Nov 2014 16:21:38 +0100
Subject: [PATCH v3 0/4] spi: Add support for Amlogic Meson SPIFC
Message-ID: <1416669702-7841-1-git-send-email-b.galvani@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this patchset adds a driver for the SPIFC (SPI flash controller)
available in Amlogic Meson6 and Meson8 SoCs. The driver has been
tested on a Meson8 based device to communicate with a Macronix
mx25l1606e serial flash.

Changes since v2 [ https://lkml.org/lkml/2014/11/17/669 ]:
 - introduce spi_transfer_is_last() helper instead of using a flag
   in spi_transfer structure
 - rebase DTS patch on arm-soc

Changes since v1 [ https://lkml.org/lkml/2014/11/9/35 ]:
 - decrease busy wait timeout
 - remove check on xfer->speed_hz value in meson_spifc_transfer_one()
 - implement transfer_one() instead of transfer_one_message()
 - remove useless memset of devdata
 - use fixed regmap config
 - implement PM operations
 - don't set master->bus_num
 - allow modular build of the driver

Beniamino Galvani (4):
  spi: core: Add spi_transfer_is_last() helper
  spi: meson: Add device tree bindings documentation for SPIFC
  spi: meson: Add support for Amlogic Meson SPIFC
  ARM: dts: meson: add node for SPIFC

 .../devicetree/bindings/spi/spi-meson.txt          |  22 +
 arch/arm/boot/dts/meson.dtsi                       |   9 +
 drivers/spi/Kconfig                                |   7 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-meson-spifc.c                      | 462 +++++++++++++++++++++
 include/linux/spi/spi.h                            |   6 +
 6 files changed, 507 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-meson.txt
 create mode 100644 drivers/spi/spi-meson-spifc.c

-- 
1.9.1

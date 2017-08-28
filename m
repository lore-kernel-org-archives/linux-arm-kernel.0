From: mw@semihalf.com (Marcin Wojtas)
Date: Mon, 28 Aug 2017 23:14:12 +0200
Subject: [PATCH 0/2] SPI NOR - force 3byte addressing mode
Message-ID: <1503954854-30963-1-git-send-email-mw@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This very short patchset introduces optional forcing via DT
3byte addressing mode for accessing the SPI flash, whose
size exceeds 16MiB.

It can be used in case the device does not support
SPI_NOR_4B_OPCODES and helps overcome an issue, when
the Boot ROM cannot handle non-default settings
that could be enabled in the kernel and remain after soft reset.

I'm looking forward to any comments or remarks.

Best regards,
Marcin

Marcin Wojtas (2):
  mtd: spi-nor: add an option to force 3byte adressing mode
  arm64: dts: marvell: Force 3byte addressing mode for SPI on A7040 DB

 Documentation/devicetree/bindings/spi/spi-bus.txt |  2 ++
 arch/arm64/boot/dts/marvell/armada-7040-db.dts    |  1 +
 drivers/mtd/spi-nor/spi-nor.c                     | 12 +++++++++++-
 3 files changed, 14 insertions(+), 1 deletion(-)

-- 
1.8.3.1

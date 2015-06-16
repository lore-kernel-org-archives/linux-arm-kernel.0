From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Tue, 16 Jun 2015 12:09:29 +0200
Subject: [PATCH v4 0/2] spi: atmel: add support to FIFOs and the internal
 chip-select
Message-ID: <cover.1434448837.git.cyrille.pitchen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ChangeLog

v4:
- remove the chip-select patch from the series as it has already been applied
- reword the commit message of the DT bindings patch to better explain why we
  use a new DT property, "atmel,fifo-size" instead of relying on the VERSION
  register or the "compatible" string.
- reword the commit message of the actual FIFO patch to better explain what
  are the MULTIPLE and SINGLE data modes and how to use them properly.
- add Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

v3:
- replace "Alternative Command Mode" by "Chip Select Active After Transfer" in
  the DT bindings documentation. The "Alternative Command Mode" is a feature of
  the I2C controller.
- rename somes "size" variables to "num_data" to ease the distinction between
  the number of bytes and the number of data to transfer.

v2:
- read the Status Register to clear its RX FIFO Threshold Flag (RXFTHF) before
  writing into the IER to enable the RXFTHF interrupt.
- remove the reset of the FIFO Mode Register (FMR) at the end of transfers
  because setting the RX FIFO Threshold to 0 also sets the RXFTHF bit in SR.
- add a 3rd patch in the series to update the documentation of DT bindings.

v1:
This series of patches add support to features introduced by the Atmel sama5d2x
SoC

Cyrille Pitchen (2):
  spi: atmel: update DT bindings documentation
  spi: atmel: add support to FIFOs

 .../devicetree/bindings/spi/spi_atmel.txt          |   8 +-
 drivers/spi/spi-atmel.c                            | 255 ++++++++++++++++++++-
 2 files changed, 252 insertions(+), 11 deletions(-)

-- 
1.8.2.2

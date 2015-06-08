From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Mon, 8 Jun 2015 18:07:41 +0200
Subject: [PATCH v2 0/3] spi: atmel: add support to FIFOs and the internal
 chip-select
Message-ID: <cover.1433779081.git.cyrille.pitchen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ChangeLog

v2:
- read the Status Register to clear its RX FIFO Threshold Flag (RXFTHF) before
  writing into the IER to enable the RXFTHF interrupt.
- remove the reset of the FIFO Mode Register (FMR) at the end of transfers
  because setting the RX FIFO Threshold to 0 also sets the RXFTHF bit in SR.
- add a 3rd patch in the series to update the documentation of DT bindings.

v1:
This series of patches add support to features introduced by the Atmel sama5d2x
SoC

Cyrille Pitchen (3):
  spi: atmel: add support for the internal chip-select of the spi
    controller
  spi: atmel: update DT bindings documentation
  spi: atmel: add support to FIFOs

 .../devicetree/bindings/spi/spi_atmel.txt          |   8 +-
 drivers/spi/spi-atmel.c                            | 276 +++++++++++++++++++--
 2 files changed, 264 insertions(+), 20 deletions(-)

-- 
1.8.2.2

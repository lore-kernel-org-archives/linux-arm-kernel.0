From: vigneshr@ti.com (Vignesh R)
Date: Fri, 29 Dec 2017 14:41:01 +0530
Subject: [PATCH v2 0/2] CQSPI: Add direct mode support
Message-ID: <20171229091103.14436-1-vigneshr@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series enables use Direct access controller on Cadence QSPI
which helps in accessing QSPI flash in memory mapped mode.

On TI platforms, this mode has higher throughput compared to indirect
access mode.

Tested on TI's 66AK2G GP EVM.

It would be great if this patch series could be tested SoCFPGA as well.
Although, this patch should have no effect on non TI platforms as driver
continues to use indirect mode when direct access memory window is less
than size of connected flash.


Vignesh R (2):
  mtd: spi-nor: cadence-quadspi: Refactor indirect read/write sequence.
  mtd: spi-nor: cadence-quadspi: Add support for direct access mode

 drivers/mtd/spi-nor/cadence-quadspi.c | 54 +++++++++++++++++++++++++----------
 1 file changed, 39 insertions(+), 15 deletions(-)

-- 
2.15.1

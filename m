From: vigneshr@ti.com (Vignesh R)
Date: Tue, 3 Oct 2017 10:49:19 +0530
Subject: [PATCH v4 0/6] K2G: Add QSPI support
Message-ID: <20171003051925.8821-1-vigneshr@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



This series adds support for Cadence QSPI IP present in TI's 66AK2G SoC.
The patches enhance the existing cadence-quadspi driver to support
loopback clock circuit, pm_runtime support and tweaks for 66AK2G SoC.

Change log:

v4:
* New patch to fix error handling sequence in probe.

v3:
* Fix build warnings reported by kbuild test bot.

Resend:
* Rebase to latest linux-next.
* Collect Acked-bys

v2:
* Drop DT patches. Will be sent as separate series as requested by
 maintainer.
* Split binding docs into separate patches.
* Address comments by Rob Herring.

Vignesh R (6):
  mtd: spi-nor: cadence-quadspi: Add TI 66AK2G SoC specific compatible
  mtd: spi-nor: cadence-quadspi: add a delay in write sequence
  mtd: spi-nor: cadence-quadspi: Add new binding to enable loop-back
    circuit
  mtd: spi-nor: cadence-quadspi: Add support to enable loop-back clock
    circuit
  mtd: spi-nor: cadence-quadspi: Fix error path in probe
  mtd: spi-nor: cadence-quadspi: Add runtime PM support

 .../devicetree/bindings/mtd/cadence-quadspi.txt    |  7 ++-
 drivers/mtd/spi-nor/cadence-quadspi.c              | 55 +++++++++++++++++++---
 2 files changed, 55 insertions(+), 7 deletions(-)

-- 
2.14.1

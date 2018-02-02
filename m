From: yogeshnarayan.gaur@nxp.com (Yogesh Gaur)
Date: Fri,  2 Feb 2018 11:01:22 +0530
Subject: [PATCH v2 0/2] mtd: fsl-quadspi: Update slave device hwcap based on
 mode provided in dtsi file
Message-ID: <1517549484-6024-1-git-send-email-yogeshnarayan.gaur@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch-set added support to update hwcap of slave device connected to
FSL QUADSPI controller by reading values from the device tree files.

Mode information is available via "spi-tx-bus-width" and
"spi-rx-bus-width" nodes of device tree for the connected slave device.

Update read and write hwcap capability for slave device by reading
"spi-rx-bus-width" and "spi-tx-bus-width" respectively.

Added usage example for spi-rx/tx-bus-width properties in spi-bus.txt

Depends on
 https://patchwork.ozlabs.org/project/linux-mtd/list/?series=26084

Yogesh Gaur (2):
  mtd: fsl-quadspi: Update slave device hwcap based on mode provided in
    dtsi file
  dt-bindings: spi: updated usage example for spi-rx/tx-bus-width
    properties

Changes for v2:
- Drop patch 'dt-bindings: fsl-quadspi: spi-rx/tx-bus-width usage example'
- Added usage example for spi-rx/tx-bus-width properties in spi-bus.txt

 Documentation/devicetree/bindings/spi/spi-bus.txt |  2 +
 drivers/mtd/spi-nor/fsl-quadspi.c                 | 56 +++++++++++++++++++++--
 2 files changed, 53 insertions(+), 5 deletions(-)

-- 
1.9.1

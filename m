From: yogeshnarayan.gaur@nxp.com (Yogesh Gaur)
Date: Tue, 13 Feb 2018 12:21:13 +0530
Subject: [PATCH v3 0/2] mtd: fsl-quadspi: Update slave device hwcap based on
 mode provided in dtsi file
Message-ID: <1518504675-26286-1-git-send-email-yogeshnarayan.gaur@nxp.com>
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

Changes for v3:
- Incorporated changes as per Cyrille's review comments.
Changes for v2:
- Drop patch 'dt-bindings: fsl-quadspi: spi-rx/tx-bus-width usage example'
- Added usage example for spi-rx/tx-bus-width properties in spi-bus.txt

 Documentation/devicetree/bindings/spi/spi-bus.txt |  2 +
 drivers/mtd/spi-nor/fsl-quadspi.c                 | 72 +++++++++++++++++++++--
 2 files changed, 69 insertions(+), 5 deletions(-)

-- 
1.9.1

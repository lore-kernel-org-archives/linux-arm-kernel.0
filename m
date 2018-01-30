From: yogeshnarayan.gaur@nxp.com (Yogesh Gaur)
Date: Tue, 30 Jan 2018 23:03:55 +0530
Subject: [PATCH 0/2] mtd: fsl-quadspi: Update slave device hwcap based on mode
 provided in dtsi file
Message-ID: <1517333637-17331-1-git-send-email-yogeshnarayan.gaur@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch-set added support to update hwcap of slave device connected to
FSL QUADSPI controller by reading values from the device tree files.

Mode information is available via "spi-tx-bus-width" and
"spi-rx-bus-width" nodes of device tree for the connected slave device.

Update read and write hwcap capability for slave device by reading
"spi-rx-bus-width" and "spi-tx-bus-width" respectively.

Added usage example by adding support for spi-rx-bus-width
and spi-tx-bus-width binding.

Depends on
 https://patchwork.ozlabs.org/project/linux-mtd/list/?series=26084

Yogesh Gaur (2):
  mtd: fsl-quadspi: Update slave device hwcap based on mode provided in
    dtsi file
  dt-bindings: fsl-quadspi: spi-rx/tx-bus-width usage example

 .../devicetree/bindings/mtd/fsl-quadspi.txt        | 30 ++++++++++++
 drivers/mtd/spi-nor/fsl-quadspi.c                  | 56 ++++++++++++++++++++--
 2 files changed, 81 insertions(+), 5 deletions(-)

-- 
1.9.1

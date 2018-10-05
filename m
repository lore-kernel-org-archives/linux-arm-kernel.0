From: pankaj.bansal@nxp.com (Pankaj Bansal)
Date: Fri,  5 Oct 2018 14:25:03 +0530
Subject: [PATCH 0/2] add i2c controlled qixis driver
Message-ID: <20181005085505.29024-1-pankaj.bansal@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

FPGA on LX2160AQDS/LX2160ARDB connected on I2C bus, so add qixis
driver which is basically an i2c client driver to control FPGA.

This driver is essential to control MDIO mux multiplexing.

Cc: Varun Sethi <V.Sethi@nxp.com>

Pankaj Bansal (2):
  dt-bindings: soc: fsl: Document Qixis FPGA usage
  fsl: add i2c controlled qixis driver

 .../bindings/soc/fsl/qixis_ctrl.txt           | 33 ++++++++
 drivers/soc/fsl/Kconfig                       |  9 +++
 drivers/soc/fsl/Makefile                      |  1 +
 drivers/soc/fsl/qixis_ctrl.c                  | 75 +++++++++++++++++++
 include/linux/fsl/qixis_ctrl.h                | 20 +++++
 5 files changed, 138 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/fsl/qixis_ctrl.txt
 create mode 100644 drivers/soc/fsl/qixis_ctrl.c
 create mode 100644 include/linux/fsl/qixis_ctrl.h

-- 
2.17.1

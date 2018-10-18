From: aisheng.dong@nxp.com (A.s. Dong)
Date: Thu, 18 Oct 2018 17:25:52 +0000
Subject: [PATCH V7 0/3] soc: imx: add scu power domain driver
Message-ID: <1539883285-7990-1-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set adds the scu based power domain driver.
It depends on SCU driver.

Change Log:
v6->v7:
 * keep "fsl,scu-pd" as fall back compatible string
v5->v6:
 * only compatible string name updated from fsl,scu-pd to fsl,imx8qxp-scu-pd
   accordingly
v4->v5:
 * some minor improvements according to Sascha's suggestion
   Note: did not use dev_* print functions due to we already have proper
         prefix by redefining pr_fmt. So it seems not quite neccesary
	 to pass in a struct device * pointer for debug purpose only in
	 each functions.
v3->v4:
 * only scu headfile path update

v2->v3:
 * structure and enums name update
 * api usage update

Dong Aisheng (3):
  dt-bindings: fsl: scu: make power domain compatible string SoC
    specific
  firmware: imx: add pm svc headfile
  firmware: imx: add SCU power domain driver

 .../devicetree/bindings/arm/freescale/fsl,scu.txt  |   6 +-
 drivers/firmware/imx/Kconfig                       |   6 +
 drivers/firmware/imx/Makefile                      |   3 +-
 drivers/firmware/imx/scu-pd.c                      | 164 +++++++++++++++++++++
 include/linux/firmware/imx/sci.h                   |   1 +
 include/linux/firmware/imx/svc/pm.h                |  85 +++++++++++
 6 files changed, 262 insertions(+), 3 deletions(-)
 create mode 100644 drivers/firmware/imx/scu-pd.c
 create mode 100644 include/linux/firmware/imx/svc/pm.h

-- 
2.7.4

From: aisheng.dong@nxp.com (A.s. Dong)
Date: Wed, 10 Oct 2018 10:32:40 +0000
Subject: [PATCH V5 0/2] soc: imx: add scu power domain driver
Message-ID: <1539166644-29215-1-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set adds the scu based power domain driver.
It depends on SCU driver.

Change Log:
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

Dong Aisheng (2):
  firmware: imx: add pm svc headfile
  firmware: imx: add SCU power domain driver

 drivers/firmware/imx/Kconfig        |   6 ++
 drivers/firmware/imx/Makefile       |   3 +-
 drivers/firmware/imx/scu-pd.c       | 164 ++++++++++++++++++++++++++++++++++++
 include/linux/firmware/imx/sci.h    |   1 +
 include/linux/firmware/imx/svc/pm.h |  85 +++++++++++++++++++
 5 files changed, 258 insertions(+), 1 deletion(-)
 create mode 100644 drivers/firmware/imx/scu-pd.c
 create mode 100644 include/linux/firmware/imx/svc/pm.h

-- 
2.7.4

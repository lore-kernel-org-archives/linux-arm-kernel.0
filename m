From: aisheng.dong@nxp.com (A.s. Dong)
Date: Tue, 30 Oct 2018 14:10:46 +0000
Subject: [PATCH RESEND V3 0/2] pinctrl: imx: add imx8qxp pinctrl support
Message-ID: <1540908354-26809-1-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rebased with latest pinctrl/for-next tree, compiling and function
tested on IMX6Q SDB.

This patch series adds i.MX8QXP pinctrl support which is based on
the pad service provided by SCU firmware.

The binding part is also merged into scu binding doc according to
Rob's suggestion.
https://www.spinics.net/lists/arm-kernel/msg680738.html

v2->v3:
 * Pad name update (add IMX8QXP prefix)

v1->v2:
 * scu firmware headfile path update
 * structure name and api usage update
 * move SCU Pad API implementation into driver
 * add binding headfile pad-imx8qxp.h

Dong Aisheng (2):
  pinctrl: fsl: add scu based pinctrl support
  pinctrl: imx: add imx8qxp driver

 drivers/pinctrl/freescale/Kconfig           |  11 +
 drivers/pinctrl/freescale/Makefile          |   2 +
 drivers/pinctrl/freescale/pinctrl-imx.c     | 425 ++++++++++------
 drivers/pinctrl/freescale/pinctrl-imx.h     |  67 ++-
 drivers/pinctrl/freescale/pinctrl-imx8qxp.c | 232 +++++++++
 drivers/pinctrl/freescale/pinctrl-scu.c     | 121 +++++
 include/dt-bindings/pinctrl/pads-imx8qxp.h  | 751 ++++++++++++++++++++++++++++
 7 files changed, 1439 insertions(+), 170 deletions(-)
 create mode 100644 drivers/pinctrl/freescale/pinctrl-imx8qxp.c
 create mode 100644 drivers/pinctrl/freescale/pinctrl-scu.c
 create mode 100644 include/dt-bindings/pinctrl/pads-imx8qxp.h

-- 
2.7.4

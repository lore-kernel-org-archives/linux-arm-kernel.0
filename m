From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 22 Sep 2011 13:10:15 +0800
Subject: [PATCH v4 0/3] add fec support for imx6q
Message-ID: <1316668218-10194-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds imx6q enet support.  The imx6q enet is a derivative of
imx28 enet controller.  It fixed the frame endian issue found on imx28,
and added 1 Gbps support.

Changes since v3:
 * The minus one on phy_speed should happend before left shift.

Changes since v2:
 * Refine patch #1 to get fec_reset_phy() return void

Changes since v1:
 * Fix typo pointed out by Francois Romieu
 * Drop patch #3 in the v1
 * Rebase on net-next tree

Thanks.

Shawn Guo (3):
      net/fec: fec_reset_phy() does not need to always succeed
      net/fec: fix fec1 check in fec_enet_mii_init()
      net/fec: add imx6q enet support

 drivers/net/ethernet/freescale/Kconfig |    9 ++--
 drivers/net/ethernet/freescale/fec.c   |   79 +++++++++++++++++++++++---------
 2 files changed, 61 insertions(+), 27 deletions(-)

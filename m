From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 21 Sep 2011 19:10:29 +0800
Subject: [PATCH v2 0/3] add fec support for imx6q
Message-ID: <1316603432-20032-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds imx6q enet support.  The imx6q enet is a derivative of
imx28 enet controller.  It fixed the frame endian issue found on imx28,
and added 1 Gbps support.

Changes since v1:
 * Fix typo pointed out by Francois Romieu
 * Drop patch #3 in the v1
 * Rebase on net-next tree

Thanks.

Shawn Guo (3):
      net/fec: change phy-reset-gpio request warning to debug message
      net/fec: fix fec1 check in fec_enet_mii_init()
      net/fec: add imx6q enet support

 drivers/net/ethernet/freescale/Kconfig |    9 ++--
 drivers/net/ethernet/freescale/fec.c   |   65 +++++++++++++++++++++++++-------
 2 files changed, 55 insertions(+), 19 deletions(-)

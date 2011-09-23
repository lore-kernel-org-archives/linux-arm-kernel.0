From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 23 Sep 2011 20:12:45 +0800
Subject: [PATCH v5 0/3] add fec support for imx6q
Message-ID: <1316779968-21390-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds imx6q enet support.  The imx6q enet is a derivative of
imx28 enet controller.  It fixes the frame endian issue found on imx28,
and adds 1 Gbps support.

Changes since v4:
 * Confirmed with design team that i.MX28 Reference Manual has an error
   on MII_SPEED formula.  FEC uses 'ref_freq / (MII_SPEED x 2)' while
   ENET-MAC uses 'ref_freq / ((MII_SPEED + 1) x 2)', so that minus one
   should really apply for just FEC_QUIRK_ENET_MAC.

Changes since v3:
 * The minus one on phy_speed should happen before left shift.

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
 drivers/net/ethernet/freescale/fec.c   |   81 +++++++++++++++++++++++---------
 2 files changed, 63 insertions(+), 27 deletions(-)

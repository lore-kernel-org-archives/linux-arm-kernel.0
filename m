From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 18 Sep 2011 19:54:08 +0800
Subject: [PATCH 0/4] add fec support for imx6q
Message-ID: <1316346852-17090-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds imx6q enet support.  The imx6q enet is a derivative of
imx28 enet controller.  It fixed the frame endian issue found on imx28,
and added 1 Gbps support.

It's based on v3.1-rc6.

Shawn Guo (4):
      net/fec: change phy-reset-gpio request warning to debug message
      net/fec: fix fec1 check in fec_enet_mii_init()
      net/fec: set phy_speed to the optimal frequency 2.5 MHz
      net/fec: add imx6q enet support

 drivers/net/Kconfig |    3 +-
 drivers/net/fec.c   |   65 ++++++++++++++++++++++++++++++++++++++++-----------
 2 files changed, 52 insertions(+), 16 deletions(-)

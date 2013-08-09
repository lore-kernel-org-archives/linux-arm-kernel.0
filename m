From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri,  9 Aug 2013 14:20:49 +0200
Subject: [PATCH] pinctrl: i.MX: Make more robust against devicetree errors
Message-ID: <1376050854-3303-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When there is something wrong with pinctrl in the i.MX devicetree
files this usually means the i.MX pinctrl driver bails out completely.
In this case even the console is nonfunctional since it can't get
the pins. Enabling earlyprintk isn't very helpful since the driver
only prints that something is wrong, but not what is wrong.

With this series the i.MX pinctrl driver continues on errors so that
the system stays working and only the erroneous pinctrl groups fail
later. Also the error messages are supplemented with the offending
devicetree node to give a clue what went wrong.

Sascha

----------------------------------------------------------------
Sascha Hauer (5):
      pinctrl: imx: make error messages more informative
      pinctrl: imx: Catch no fsl,pins property
      pinctrl: imx: do not fail when parsing a group fails
      pinctrl: imx: do not fail when parsing a function fails
      pinctrl: imx: Use struct type for pins

 drivers/pinctrl/pinctrl-imx.c | 95 ++++++++++++++++++++-----------------------
 drivers/pinctrl/pinctrl-imx.h | 36 +++++++++-------
 2 files changed, 64 insertions(+), 67 deletions(-)

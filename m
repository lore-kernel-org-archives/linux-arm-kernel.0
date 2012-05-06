From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun,  6 May 2012 20:58:09 +0800
Subject: [PATCH 0/5] Adopt pinctrl API for a few outstanding imx drivers
Message-ID: <1336309094-18517-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With patch 5b3aa5f (pinctrl: add pinctrl_provide_dummies interface for
platforms to use) applied on pinctrl tree, and patch "ARM: imx: enable
pinctrl dummy states" [1] being there, we are ready to adopt pinctrl
API for imx drivers.  So let's start from a few outstanding ones.

I would expect to ask Arnd and Olof to pull pinctrl tree into arm-soc
as a dependency and then have series [1] and this patch set go through
arm-soc tree to ease the merge process.

Regards,
Shawn

[1] http://thread.gmane.org/gmane.linux.kernel.mmc/14180

Shawn Guo (5):
  tty: serial: imx: adopt pinctrl API
  net: fec: adopt pinctrl API
  can: flexcan: adopt pinctrl API
  i2c: imx: adopt pinctrl API
  spi/imx: adopt pinctrl API

 drivers/i2c/busses/i2c-imx.c         |    8 ++++++++
 drivers/net/can/flexcan.c            |    6 ++++++
 drivers/net/ethernet/freescale/fec.c |    9 +++++++++
 drivers/spi/spi-imx.c                |    8 ++++++++
 drivers/tty/serial/imx.c             |    8 ++++++++
 5 files changed, 39 insertions(+), 0 deletions(-)

-- 
1.7.5.4

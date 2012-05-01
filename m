From: marex@denx.de (Marek Vasut)
Date: Tue,  1 May 2012 04:00:17 +0200
Subject: =?UTF-8?q?=5BPATCH=200/4=5D=20MXS=3A=20I2C=20improvements?=
Message-ID: <1335837621-14816-1-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset implements support for adjustment of I2C bus speed via platform
data. Further, it implements support for DMA transfers into the mxs-i2c driver.
Lastly, there is a fix for GCC4.7 warning included.

Marek Vasut (4):
  MXS: Allow passing i2c bus speed via platform data
  MXS: Set I2C timing registers for mxs-i2c
  MXS: Implement DMA support into mxs-i2c
  MXS: Fix GCC4.7 complaint in mxs-i2c

 arch/arm/mach-mxs/devices-mx28.h                |    3 +-
 arch/arm/mach-mxs/devices/platform-mxs-i2c.c    |   14 +-
 arch/arm/mach-mxs/include/mach/devices-common.h |    5 +-
 arch/arm/mach-mxs/mach-apx4devkit.c             |    7 +-
 arch/arm/mach-mxs/mach-m28evk.c                 |    8 +-
 arch/arm/mach-mxs/mach-mx28evk.c                |    7 +-
 arch/arm/mach-mxs/mach-tx28.c                   |    7 +-
 drivers/i2c/busses/i2c-mxs.c                    |  304 +++++++++++++++++++++--
 include/linux/i2c/mxs-i2c.h                     |   22 ++
 9 files changed, 343 insertions(+), 34 deletions(-)
 create mode 100644 include/linux/i2c/mxs-i2c.h

Cc: Detlev Zundel <dzu@denx.de>
CC: Dong Aisheng <b29396@freescale.com>
CC: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Linux ARM kernel <linux-arm-kernel@lists.infradead.org>
Cc: linux-i2c at vger.kernel.org
CC: Sascha Hauer <s.hauer@pengutronix.de>
CC: Shawn Guo <shawn.guo@linaro.org>
Cc: Stefano Babic <sbabic@denx.de>
CC: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Cc: Wolfgang Denk <wd@denx.de>
Cc: Wolfram Sang <w.sang@pengutronix.de>

-- 
1.7.10

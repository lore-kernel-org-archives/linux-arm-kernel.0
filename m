From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 12 Jul 2012 11:57:46 +0200
Subject: [PATCH 0/7] Add support for Freescale's mc34708 to mc13xxx driver
Message-ID: <1342087073-3892-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This series was tested on a Phytec pcm038 (mc13783 on spi) using
traditional boot (i.e. not dt) and on a i.MX53 based machine (mc34708 on
i2c) using dt boot.

Philippe's patches are already in next, they are just included here for
those who want to test the patches. The 'mfd/mc13xxx: drop modifying
driver's id_table in probe' was already sent out yesterday and is
included here because the last patch depends on it.

Best regards
Uwe

Philippe R?tornaz (2):
  MFD: Fix mc13xxx SPI regmap
  MFD: mc13xxx workaround SPI hardware bug on i.Mx

Uwe Kleine-K?nig (5):
  rtc/mc13xxx: use MODULE_DEVICE_TABLE instead of MODULE_ALIAS
  rtc/mc13xxx: add support for the rtc in the mc34708 pmic
  mfd/mc13xxx: drop modifying driver's id_table in probe
  mfd/mc13xxx: change probing details for mc13xxx devices
  mfd/mc13xxx: add support for mc34708

 drivers/mfd/mc13xxx-core.c |   94 ++++++++++++++++++++--------------------
 drivers/mfd/mc13xxx-i2c.c  |   28 ++++++------
 drivers/mfd/mc13xxx-spi.c  |  102 +++++++++++++++++++++++++++++++++++---------
 drivers/mfd/mc13xxx.h      |   18 +++++---
 drivers/rtc/rtc-mc13xxx.c  |    6 ++-
 5 files changed, 159 insertions(+), 89 deletions(-)

-- 
1.7.10.4

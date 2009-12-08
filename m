From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 8 Dec 2009 22:12:58 +0100
Subject: [PATCH 0/5] spi-imx: some updates
Message-ID: <20091208211258.GA13706@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

this series depends on "spi: drain MXC SPI transfer buffer when probing
device" which is currently in -mm and also included in my spi-imx branch
(see below).  IMHO at least my first patch should go into .33 as it
fixes an oops.

I'll post the patches for review as a reply to this mail.

Best regards
Uwe

The following changes since commit 6035ccd8e9e40bb654fbfdef325902ab531679a5:
  Linus Torvalds (1):
        Merge branch 'for-2.6.33' of git://git.kernel.dk/linux-2.6-block

are available in the git repository at:

  git://git.pengutronix.de/git/ukl/linux-2.6.git spi-imx

Daniel Mack (1):
      spi: drain MXC SPI transfer buffer when probing device

Sascha Hauer (1):
      spi-imx: Add mx25 support

Uwe Kleine-K?nig (4):
      spi-imx: use platform_driver_probe as probe lives in .init.text
      spi-imx: correct check for platform_get_irq failing
      spi-imx: use positive logic to distinguish cpu variants
      spi-imx: don't access struct device directly but use dev_get_platdata

 drivers/spi/spi_imx.c |   23 +++++++++++++++--------
 1 files changed, 15 insertions(+), 8 deletions(-)
-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |

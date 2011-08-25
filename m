From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 25 Aug 2011 11:03:34 +0200
Subject: i.MX SDMA patches
Message-ID: <1314263017-18099-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following series has some i.MX SDMA fixes. The first two
should go into -rc, the third either in -rc or next. It fixes
that the driver blocks in probe() when the driver is compiled
into the kernel but the firmware is not. From this point of
view it should go in -rc, but on the other hand it's no straight
forward fix.

Sascha

Sascha Hauer (3):
      dmaengine i.MX SDMA: lock channel 0
      dmaengine i.MX SDMA: set firmware scripts addresses to negative value initially
      dmaengine i.MX SDMA: use request_firmware_nowait

 drivers/dma/imx-sdma.c |   47 ++++++++++++++++++++++++++++++++++++++---------
 1 files changed, 38 insertions(+), 9 deletions(-)

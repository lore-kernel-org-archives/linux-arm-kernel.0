From: m.grzeschik@pengutronix.de (Michael Grzeschik)
Date: Thu, 15 Nov 2012 13:03:41 +0100
Subject: [PATCH v2 0/7] support other fsl SoCs with usbmisc + small fixes
Message-ID: <1352981028-14312-1-git-send-email-m.grzeschik@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nearly every SoC from Freescale has this non-core usb registers. This series
adds support for more users of this driver.

This series is based on Peter Chen's work. Its needed to merge his master branch
before applying this series:

https://github.com/hzpeterchen/linux-usb.git

Thanks,
Michael

Marc Kleine-Budde (4):
  usb: chipidea: usbmisc: unset global varibale usbmisc on driver remove
  usb: chipidea: usbmisc: fix a potential race condition
  usb: chipidea: usbmisc: prepare driver to handle more than one soc
  usb: chipidea: usbmisc: add support for ahb, ipg and per clock

Michael Grzeschik (3):
  usb: chipidea: usbmisc: rename file, struct and functions to usbmisc_imx
  usb: chipidea: usbmisc: add mx53 support
  usb: chipidea: usbmisc: add post handling and errata fix for mx25

 .../devicetree/bindings/usb/ci13xxx-imx.txt        |    2 +
 drivers/usb/chipidea/Makefile                      |    2 +-
 drivers/usb/chipidea/ci13xxx_imx.c                 |   12 +
 drivers/usb/chipidea/ci13xxx_imx.h                 |    3 +
 drivers/usb/chipidea/usbmisc_imx.c                 |  256 ++++++++++++++++++++
 drivers/usb/chipidea/usbmisc_imx6q.c               |  162 -------------
 6 files changed, 274 insertions(+), 163 deletions(-)
 create mode 100644 drivers/usb/chipidea/usbmisc_imx.c
 delete mode 100644 drivers/usb/chipidea/usbmisc_imx6q.c

-- 
1.7.10.4

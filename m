From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri,  5 Oct 2012 18:12:58 +0200
Subject: [PATCH v2] Add of helper for linux,stdout-path
Message-ID: <1349453581-1685-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a helper function to match the linux,stdout-path property
against a struct device and adds support for this property to the i.MX
serial driver.

Sascha

----------------------------------------------------------------
Sascha Hauer (3):
      serial_core: Add helper for matching against linux,stdout-path
      serial: i.MX: Make console support non optional
      serial: i.MX: evaluate linux,stdout-path property

 drivers/tty/serial/Kconfig       |   16 +---------------
 drivers/tty/serial/imx.c         |   11 ++++-------
 drivers/tty/serial/serial_core.c |   30 ++++++++++++++++++++++++++++++
 include/linux/serial_core.h      |    3 +++
 4 files changed, 38 insertions(+), 22 deletions(-)

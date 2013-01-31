From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 31 Jan 2013 12:32:15 +0100
Subject: [PATCH] USB chipidea i.MX: use framework phy handling
Message-ID: <1359631937-26646-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series switches the mxs phy and the i.MX chipidea support
from homegrew phy support to use usb_add_phy_dev/devm_usb_get_phy_by_phandle.

Based on

[PATCH v2] Add USB of helpers and use them in the chipidea driver

But I think this could also be applied separately if necessary.

Sascha

----------------------------------------------------------------
Sascha Hauer (2):
      USB mxs-phy: Register phy with framework
      USB chipidea i.MX: use devm_usb_get_phy_by_phandle to get phy

 drivers/usb/chipidea/ci13xxx_imx.c |   31 ++++++++++---------------------
 drivers/usb/otg/mxs-phy.c          |    9 +++++++++
 2 files changed, 19 insertions(+), 21 deletions(-)

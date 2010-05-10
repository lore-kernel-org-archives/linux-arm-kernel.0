From: philippe.retornaz@epfl.ch (=?utf-8?q?Philippe=20R=C3=A9tornaz?=)
Date: Mon, 10 May 2010 20:13:39 +0200
Subject: [PATCH 0/1] mx31: Fix usb otg host initialisation
Message-ID: <1273515220-18909-1-git-send-email-philippe.retornaz@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello

This patch fix the usb otg host initialisation on imx31 platform.
The ULPI access had timeout problem. This try to fix them by reseting 
the host controller before accessing the PHY.
With a such reset the configuration registers need to be rewritten after
the ULPI access.

Tested on 3 different board with an imx31.

Regards,
Philippe


Philippe Retornaz (1):
  ehci-mxc: Fix mx31 OTG host initialisation

 drivers/usb/host/ehci-mxc.c |   68 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 68 insertions(+), 0 deletions(-)

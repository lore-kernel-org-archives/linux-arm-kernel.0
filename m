From: philippe.retornaz@epfl.ch (=?utf-8?q?Philippe=20R=C3=A9tornaz?=)
Date: Tue, 11 May 2010 16:14:33 +0200
Subject: [PATCH 0/1 v2] mx31: Fix usb otg host initialisation
Message-ID: <1273587274-8045-1-git-send-email-philippe.retornaz@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello

This patch fix the usb otg host initialisation on imx31 platform.
The ULPI access had timeout problem. This try to fix them by resetting 
the host controller before accessing the PHY.
With a such reset the configuration registers need to be rewritten after
the ULPI access.

Tested on 3 different board with an imx31.

The v2 try to integrate all the comments. It defines new functions
to reset the host and to poll the differents bits with a timeout but
it should not change the general behavior of the code.


Regards,
Philippe

Philippe R?tornaz (1):
  ehci-mxc: Fix mx31 OTG host initialisation

 drivers/usb/host/ehci-mxc.c |   98 ++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 87 insertions(+), 11 deletions(-)

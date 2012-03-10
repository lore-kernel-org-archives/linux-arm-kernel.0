From: stigge@antcom.de (Roland Stigge)
Date: Sat, 10 Mar 2012 20:36:03 +0100
Subject: [PATCH v5 0/3] USB: OHCI-HCD: Support for LPC32xx
Message-ID: <1331408166-11607-1-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for the LPC32xx to the ohci-pnx4008 driver.

As discussed with Greg-KH on the USB mailing list, the ohci-pnx4008 driver is
first renamed to reflect its multi-platform support. The second patch also
renames the respective pnx4008_* symbols accordingly. The third and final patch
adds the actual lpc32xx support.

Applies to v3.3-rc6

Signed-off-by: Roland Stigge <stigge@antcom.de>

---

Roland Stigge (3):
 USB: OHCI-HCD: Rename ohci-pnx4008 to ohci-nxp
 USB: ohci-nxp: Rename symbols from pnx4008 to nxp
 USB: ohci-nxp: Support for LPC32xx

 Documentation/i2c/instantiating-devices |    6 
 drivers/usb/host/ohci-hcd.c             |    6 
 drivers/usb/host/ohci-nxp.c             |  652 ++++++++++++++++++++++++++++----
 drivers/usb/host/ohci-pnx4008.c         |  453 ----------------------
 4 files changed, 596 insertions(+), 521 deletions(-)

From: stigge@antcom.de (Roland Stigge)
Date: Sun, 11 Mar 2012 02:46:12 +0100
Subject: [PATCH v6 0/3] USB: OHCI-HCD: Support for LPC32xx
Message-ID: <1331430375-31227-1-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for the LPC32xx to the ohci-pnx4008 driver.

As discussed with Greg-KH on the USB mailing list, the ohci-pnx4008 driver is
first renamed to reflect its multi-platform support. The second patch also
renames the respective pnx4008_* symbols accordingly. The third and final patch
adds the actual lpc32xx support.

Applies to v3.3-rc6

Since v5, i2c_read16() has been removed in favour of i2c_smbus_read_word_data()

Thanks to Wolfram Sang for reviewing!

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

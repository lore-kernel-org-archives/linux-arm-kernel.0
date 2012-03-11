From: stigge@antcom.de (Roland Stigge)
Date: Sun, 11 Mar 2012 11:53:35 +0100
Subject: [PATCH v7 0/4] USB: OHCI-HCD: Support for LPC32xx
Message-ID: <1331463219-23293-1-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches add support for the LPC32xx to the ohci-pnx4008 driver and make
the driver use smbus functions.

As discussed with Greg-KH on the USB mailing list, the ohci-pnx4008 driver is
first renamed to reflect its multi-platform support. The second patch also
renames the respective pnx4008_* symbols accordingly.

The third patch adds the actual lpc32xx support.

The fourth patch removes the re-coded i2c_write() by using an existing smbus
function. You can leave out this very single patch to still have the desired
LPC32xx support. It just fixes existing kernel code to only use smbus calls in
this driver.

Applies to v3.3-rc6

Since v6, i2c_write() has been removed in favour of i2c_smbus_write_byte_data()

Thanks to Wolfram Sang for reviewing!

Signed-off-by: Roland Stigge <stigge@antcom.de>

---

Roland Stigge (4):
 USB: OHCI-HCD: Rename ohci-pnx4008 to ohci-nxp
 USB: ohci-nxp: Rename symbols from pnx4008 to nxp
 USB: ohci-nxp: Support for LPC32xx
 USB: ohci-nxp: Remove i2c_write(), use smbus

 Documentation/i2c/instantiating-devices |    6 
 drivers/usb/host/ohci-hcd.c             |    6 
 drivers/usb/host/ohci-nxp.c             |  652 ++++++++++++++++++++++++++++----
 drivers/usb/host/ohci-pnx4008.c         |  453 ----------------------
 4 files changed, 596 insertions(+), 521 deletions(-)

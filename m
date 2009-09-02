From: daniel@caiaq.de (Daniel Mack)
Date: Wed,  2 Sep 2009 22:47:53 +0200
Subject: Patches for Freescale MXC SoCs and direct ULPI communication [v3]
Message-ID: <1251924478-30651-1-git-send-email-daniel@caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry for the long delay on this issue.

Here comes another round of four patches to support the EHCI ports on
Freescale's MX2/MX3 SoCs.

The difference to the last version I've sent is that the ISP1504
specific drivers has become a generic ULPI driver now with all the
defines renamed.

Also the driver does not set DRV_VBUS and DRV_VBUS_EXT blindly
anymore but uses a flags field in the otg_transceiver struct which can
be specified when creating the device. This allows the adaption of the
code to a wider variety of applications.

As a reference, I've added a patch to add board specific support code
for the lilly1131 module.

Let me know if that still works for other boards and if that version
looks better to you.

Again, #1, #2 and #4 are supposed to go thru the USB folks' channel,
while the rest might be picked by Sascha Hauer eventually.

Thanks,
Daniel

[PATCH 1/5] USB OTG: add support for ulpi connected external transceivers
[PATCH 2/5] USB OTG: Add generic driver for ULPI OTG transceiver
[PATCH 3/5] MXC: Add support for ULPI Viewports
[PATCH 4/5] USB: Add EHCI support for MX27 and MX31 based boards
[PATCH 5/5] MX3: add USB support for lilly1131

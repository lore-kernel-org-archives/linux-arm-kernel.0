From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Fri, 18 Jul 2014 11:31:21 +0200
Subject: [PATCH 0/9] usb: musb: several bugfixes for the musb driver
Message-ID: <1405675890-8802-1-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The first three patches do some source code cleanup in the files that
are modified in the subsequent patches.

Patch 4 carries the proper fix reported in commit:
        7adb5c876e9c ("usb: musb: Fix panic upon musb_am335x module removal")

Patch 6 makes the USBOTG_ID pin override via the USB_MODE register
        really work.

Patch 5 makes the error message upon driver probe failure visible
        without having to recompile the driver with DEBUG enabled.

Patch 7 makes sure the parameters for the usb_gen_phy are properly set
        up before registering it.

Patch 8 makes it possible to use the driver with HW that requires
        external regulators or clocks.

Patch 9 reinstates module unloading support for the musb_am335x driver
        which was disabled due to a false failure analysis

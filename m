From: svenkatr@ti.com (Venkatraman S)
Date: Tue, 20 Jul 2010 15:52:08 +0530
Subject: configuration warnings with omap_3630sdp_defconfig in 2.6.35-rc5
Message-ID: <AANLkTimh0MBzANu1rmLb7q1tYQMywznQd5DJ_mUKp_cZ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While trying to build omap_3630sdp_defconfig on Linus's 2.6.35-rc5, I
get these warnings..
I understand these could be related to the recent defconfig changes.
I will try to investigate; posted here to know if anyone has found a
fix already..
------------------------------
scripts/kconfig/conf -s arch/arm/Kconfig
can't copy type 0
warning: (USB_MUSB_HDRC_HCD && USB_SUPPORT && USB_MUSB_HDRC &&
(USB_MUSB_HOST || USB_MUSB_OTG) && USB_GADGET_MUSB_HDRC ||
USB_MUSB_OTG && <choice> && USB && USB_GADGET && PM && EXPERIMENTAL)
selects USB_OTG which has unmet direct dependencies (USB_GADGET_OMAP
&& ARCH_OMAP_OTG && USB_OHCI_HCD)
warning: (USB_MUSB_HDRC_HCD && USB_SUPPORT && USB_MUSB_HDRC &&
(USB_MUSB_HOST || USB_MUSB_OTG) && USB_GADGET_MUSB_HDRC ||
USB_MUSB_OTG && <choice> && USB && USB_GADGET && PM && EXPERIMENTAL)
selects USB_OTG which has unmet direct dependencies (USB_GADGET_OMAP
&& ARCH_OMAP_OTG && USB_OHCI_HCD)
------------------------------

Regards,
Venkat.

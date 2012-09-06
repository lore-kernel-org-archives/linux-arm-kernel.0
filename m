From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Thu, 6 Sep 2012 15:42:40 +1000
Subject: linux-next: manual merge of the arm-soc tree with the usb tree
Message-ID: <20120906154240.12f7e0c01686559dd43744fa@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
drivers/usb/host/Kconfig between commit 952230d774bb ("usb: ohci: Fix
Kconfig dependency on USB_ISP1301") from the usb tree and commit
d684f05f2d55 ("ARM: mach-pnx4008: Remove architecture") from the arm-soc
tree.

I fixed it up (see below) and can carry the fix as necessary (no action
required).
-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc drivers/usb/host/Kconfig
index 13cd6d5,276add2..0000000
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@@ -292,7 -292,7 +292,7 @@@ config USB_OHCI_HC
  	depends on USB && USB_ARCH_HAS_OHCI
  	select ISP1301_OMAP if MACH_OMAP_H2 || MACH_OMAP_H3
  	select USB_OTG_UTILS if ARCH_OMAP
- 	depends on USB_ISP1301 || !(ARCH_LPC32XX || ARCH_PNX4008)
 -	select USB_ISP1301 if ARCH_LPC32XX
++	depends on USB_ISP1301 || !ARCH_LPC32XX
  	---help---
  	  The Open Host Controller Interface (OHCI) is a standard for accessing
  	  USB 1.1 host controller hardware.  It does more in hardware than Intel's
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120906/a9822353/attachment-0001.sig>

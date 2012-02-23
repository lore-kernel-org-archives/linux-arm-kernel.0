From: t-kristo@ti.com (Tero Kristo)
Date: Thu, 23 Feb 2012 15:21:54 +0200
Subject: [PATCH 0/6] ARM: OMAP4: core retention support
Message-ID: <1330003320-17400-1-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This set adds core retention support on top of mainline. The set
also adds IO CHAIN wakeup capability for OMAP4, which is a nice feature
to have while trying suspend / resume with CSWR as it is quite difficult
to wake up the device without this.

Patch 6 might cause some stir, but this is needed as omap4 PRCM chain
handler currently does not work without SPARSE_IRQ. Enabling the
SPARSE_IRQ causes a WARN from gic during boot for omap4, and attempting
to fix this creates some spam from interrupt handling code which seems to
originate from GPMC/GPIO. Also, omap3 boot breaks completely,
thus it is impossible to enable this option as of now.

Tested on OMAP4 blaze board, with OMAP4430 EMU chip. Suspend / resume
works nicely, and wakeup with UART3 works. The powerdomain state info
under pm-debug appears to be somewhat bogus right after boot, but fixes
itself during suspend. This should be addressed separately. Also
verified that suspend / resume with OMAP3 beagle is okay.

-Tero

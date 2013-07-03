From: balbi@ti.com (Felipe Balbi)
Date: Wed, 3 Jul 2013 15:57:19 +0300
Subject: [RFC PATCH 4/6] USB: ehci-omap: Suspend the controller during
 bus suspend
In-Reply-To: <Pine.LNX.4.44L0.1307021302430.1086-100000@iolanthe.rowland.org>
References: <51D28DB9.704@ti.com>
 <Pine.LNX.4.44L0.1307021302430.1086-100000@iolanthe.rowland.org>
Message-ID: <20130703125719.GD15056@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jul 02, 2013 at 01:17:58PM -0400, Alan Stern wrote:
> A PCI-based EHCI controller has two power sources: the core well (which
> is turned off during suspend) and the auxiliary well (which remains
> powered).  That's how remote wakeup works; it uses the auxiliary well.

This, kinda, matches what OMAP tries to do with pad wakeup. Just that
pad wakeup sits outside of the device itself. Perhaps we could look into
how PCI handles the aux well and take some inspiration from there.

Any pointers under drivers/pci/ would be great :-)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130703/3c404967/attachment.sig>

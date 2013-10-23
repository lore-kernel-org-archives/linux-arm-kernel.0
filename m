From: balbi@ti.com (Felipe Balbi)
Date: Wed, 23 Oct 2013 13:06:57 -0500
Subject: [Patch v2 09/10] usb: chipidea: host: add ehci quirk for imx
 controller
In-Reply-To: <Pine.LNX.4.44L0.1310231043100.1326-100000@iolanthe.rowland.org>
References: <1382423019-26184-10-git-send-email-peter.chen@freescale.com>
 <Pine.LNX.4.44L0.1310231043100.1326-100000@iolanthe.rowland.org>
Message-ID: <20131023180657.GI25954@gimli>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Oct 23, 2013 at 10:46:09AM -0400, Alan Stern wrote:
> On Tue, 22 Oct 2013, Peter Chen wrote:
> 
> > When the port goes to suspend or finishes resme, it needs to
> > notify PHY, it is not a standard EHCI operation, so we add a
> > quirk for it.
> 
> Actually, this _should_ be a standard EHCI operation.  But we have to
> figure out a way to do it that will work on all platforms.
> 
> Felipe, any ideas?

isn't it enough to call usb_phy_set_suspend() at apropriate places ?

This should work on all platforms if the PHY driver is implemented
correctly.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131023/0d6262c5/attachment.sig>

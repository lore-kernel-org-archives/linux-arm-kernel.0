From: balbi@ti.com (Felipe Balbi)
Date: Tue, 5 Mar 2013 19:20:16 +0200
Subject: [V8 PATCH 01/16] usb: phy: mv_usb2: add PHY driver for marvell
 usb2 controller
In-Reply-To: <Pine.LNX.4.44L0.1303051142400.1308-100000@iolanthe.rowland.org>
References: <20130305110457.GF7899@arwen.pp.htv.fi>
 <Pine.LNX.4.44L0.1303051142400.1308-100000@iolanthe.rowland.org>
Message-ID: <20130305172016.GB5449@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 05, 2013 at 11:43:35AM -0500, Alan Stern wrote:
> On Tue, 5 Mar 2013, Felipe Balbi wrote:
> 
> > Anyway, details are as follows:
> > 
> > readl() and writel() always add a memory barrier around each operation.
> 
> Is that supposed to be true on all architectures or only on ARM?

I believe it's true for every architecture which doesn't have strongly
ordered memory accesses. ARM is just one example of that ;-)

In any case, his read->set 1 bit->write loop isn't good even for
architectures with strongly ordered memory accesses. It will continue to
post unnecessary reads and writes to the interconnect.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130305/24df4eb1/attachment.sig>

From: tony@atomide.com (Tony Lindgren)
Date: Tue, 14 Jan 2014 09:04:09 -0800
Subject: [PATCH RFC 08/26] dmaengine: omap-dma: consolidate setup of CCR
In-Reply-To: <20140114133949.GJ27282@n2100.arm.linux.org.uk>
References: <20140102150836.GA3826@n2100.arm.linux.org.uk>
 <E1VyjuU-0005EQ-H5@rmk-PC.arm.linux.org.uk>
 <20140113221425.GD7993@atomide.com>
 <20140113231227.GI27282@n2100.arm.linux.org.uk>
 <20140114133949.GJ27282@n2100.arm.linux.org.uk>
Message-ID: <20140114170409.GA13306@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [140114 05:41]:
> On Mon, Jan 13, 2014 at 11:12:27PM +0000, Russell King - ARM Linux wrote:
> > On Mon, Jan 13, 2014 at 02:14:26PM -0800, Tony Lindgren wrote:
> > > * Russell King <rmk+kernel@arm.linux.org.uk> [140102 07:17]:
> > > > Consolidate the setup of the channel control register.  Prepare the
> > > > basic value in the preparation of the DMA descriptor, and write it into
> > > > the register upon descriptor execution.
> > > 
> > > FYI, this patch seems to be the one that causes the
> > > "DMA timeout with device 55" error for omap1.
> > 
> > Okay, looks like I've missed some bit of muxing for DMA signals or
> > something.  I've yet to find any information on this in the OMAP5912
> > docs, so I guess I'm going to have to do this not only blind, but also
> > without hardware.  GAH.
> 
> Do you know which of the OMAP1 variants your device is?  Is it OMAP15xx
> or OMAP16xx?  It looks like OMAP15xx is easy to fix for this as it hasn't
> got the additional multiplexer on the DMA request signals.

This was with Nokia 770, which is 1710. Should be pretty much the same
from SoC point of view as 5912 on OSK.

Tony

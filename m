From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 14 Jan 2014 13:39:50 +0000
Subject: [PATCH RFC 08/26] dmaengine: omap-dma: consolidate setup of CCR
In-Reply-To: <20140113231227.GI27282@n2100.arm.linux.org.uk>
References: <20140102150836.GA3826@n2100.arm.linux.org.uk>
 <E1VyjuU-0005EQ-H5@rmk-PC.arm.linux.org.uk>
 <20140113221425.GD7993@atomide.com>
 <20140113231227.GI27282@n2100.arm.linux.org.uk>
Message-ID: <20140114133949.GJ27282@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 13, 2014 at 11:12:27PM +0000, Russell King - ARM Linux wrote:
> On Mon, Jan 13, 2014 at 02:14:26PM -0800, Tony Lindgren wrote:
> > * Russell King <rmk+kernel@arm.linux.org.uk> [140102 07:17]:
> > > Consolidate the setup of the channel control register.  Prepare the
> > > basic value in the preparation of the DMA descriptor, and write it into
> > > the register upon descriptor execution.
> > 
> > FYI, this patch seems to be the one that causes the
> > "DMA timeout with device 55" error for omap1.
> 
> Okay, looks like I've missed some bit of muxing for DMA signals or
> something.  I've yet to find any information on this in the OMAP5912
> docs, so I guess I'm going to have to do this not only blind, but also
> without hardware.  GAH.

Do you know which of the OMAP1 variants your device is?  Is it OMAP15xx
or OMAP16xx?  It looks like OMAP15xx is easy to fix for this as it hasn't
got the additional multiplexer on the DMA request signals.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".

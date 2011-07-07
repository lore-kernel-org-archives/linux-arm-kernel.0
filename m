From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 7 Jul 2011 12:15:26 -0600
Subject: [PATCH 01/10] ARM: change ARM_DMA_ZONE_SIZE into a variable
In-Reply-To: <201107071817.11842.arnd@arndb.de>
References: <1309919442-20451-1-git-send-email-nicolas.pitre@linaro.org>
	<20110706230945.GA8286@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1107062246130.14596@xanadu.home>
	<201107071817.11842.arnd@arndb.de>
Message-ID: <20110707181526.GB2824@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 07, 2011 at 06:17:11PM +0200, Arnd Bergmann wrote:
> On Thursday 07 July 2011, Nicolas Pitre wrote:
> > > What is hardware specific is that the DMA devices can only address a
> > > limited range of memory.  IMHO it's that which should be described in
> > > DT, not that we'll have a DMA zone of X bytes in size.
> > 
> > I think that we all agree on the principle.  I certainly never intended 
> > to suggest that the DMA zone size be stored as is in the device tree.
> 
> There is a way to specify DMA address ranges in the device tree, though
> I forgot the exact format. It comes down to saying the device sees
> memory range XXX to YYY as its local address AAA to BBB. We could use
> that information at boot time to determine what the largest range
> of memory is that is visible by all devices (and hope that it's at
> the start of physical memory).

It's called dma-ranges, and it has the same syntax as the ranges
property.  See section 2.3.9 on page 30 in ePAPR:

http://www.power.org/resources/downloads/Power_ePAPR_APPROVED_v1.0.pdf

This describes the hardware constraints, not the DMA zone size or
any software decisions like that.

g.

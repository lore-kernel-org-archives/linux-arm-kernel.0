From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 7 Jul 2011 18:17:11 +0200
Subject: [PATCH 01/10] ARM: change ARM_DMA_ZONE_SIZE into a variable
In-Reply-To: <alpine.LFD.2.00.1107062246130.14596@xanadu.home>
References: <1309919442-20451-1-git-send-email-nicolas.pitre@linaro.org>
	<20110706230945.GA8286@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1107062246130.14596@xanadu.home>
Message-ID: <201107071817.11842.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 07 July 2011, Nicolas Pitre wrote:
> > What is hardware specific is that the DMA devices can only address a
> > limited range of memory.  IMHO it's that which should be described in
> > DT, not that we'll have a DMA zone of X bytes in size.
> 
> I think that we all agree on the principle.  I certainly never intended 
> to suggest that the DMA zone size be stored as is in the device tree.

There is a way to specify DMA address ranges in the device tree, though
I forgot the exact format. It comes down to saying the device sees
memory range XXX to YYY as its local address AAA to BBB. We could use
that information at boot time to determine what the largest range
of memory is that is visible by all devices (and hope that it's at
the start of physical memory).

	Arnd

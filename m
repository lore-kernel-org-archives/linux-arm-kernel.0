From: John.Linn@xilinx.com (John Linn)
Date: Thu, 7 Jul 2011 11:08:38 -0600
Subject: [PATCH 01/10] ARM: change ARM_DMA_ZONE_SIZE into a variable
In-Reply-To: <201107071817.11842.arnd@arndb.de>
References: <1309919442-20451-1-git-send-email-nicolas.pitre@linaro.org><20110706230945.GA8286@n2100.arm.linux.org.uk><alpine.LFD.2.00.1107062246130.14596@xanadu.home>
	<201107071817.11842.arnd@arndb.de>
Message-ID: <81e4ac16-db7b-47a0-9f93-632a5d9f898d@VA3EHSMHS028.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-
> kernel-bounces at lists.infradead.org] On Behalf Of Arnd Bergmann
> Sent: Thursday, July 07, 2011 10:17 AM
> To: linux-arm-kernel at lists.infradead.org
> Cc: Nicolas Pitre; grant.likely at secretlab.ca; Russell King - ARM
Linux;
> Barry Song
> Subject: Re: [PATCH 01/10] ARM: change ARM_DMA_ZONE_SIZE into a
> variable
> 
> On Thursday 07 July 2011, Nicolas Pitre wrote:
> > > What is hardware specific is that the DMA devices can only address
> a
> > > limited range of memory.  IMHO it's that which should be described
> in
> > > DT, not that we'll have a DMA zone of X bytes in size.
> >
> > I think that we all agree on the principle.  I certainly never
> intended
> > to suggest that the DMA zone size be stored as is in the device
tree.
> 
> There is a way to specify DMA address ranges in the device tree,
though
> I forgot the exact format. It comes down to saying the device sees
> memory range XXX to YYY as its local address AAA to BBB. We could use
> that information at boot time to determine what the largest range
> of memory is that is visible by all devices (and hope that it's at
> the start of physical memory).

If I'm following this right....

We have a hole at the start of physical memory (when it's at 0) so that
DMA can't DMA into it.  Sounds like that won't work for us?

Thanks,
John

> 
> 	Arnd
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.

From: blaterblater@hotmail.com (Frank)
Date: Sun, 28 Nov 2010 13:43:46 +0100
Subject: memory allocation errors on Marvell Kirkwood
In-Reply-To: <20101128120857.GB23772@n2100.arm.linux.org.uk>
References: <BLU0-SMTP90312A69589CE7FD162BA4CF230@phx.gbl>
	<20101128120857.GB23772@n2100.arm.linux.org.uk>
Message-ID: <BLU0-SMTP32593CEE5C8F556A931E3BCF230@phx.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
> Sent: Sunday, November 28, 2010 13:09
> To: Frank
> Cc: linux-arm-kernel at lists.infradead.org
> Subject: Re: memory allocation errors on Marvell Kirkwood
> 
> On Sun, Nov 28, 2010 at 12:44:56PM +0100, Frank wrote:
> > [323570.011580] swapper: page allocation failure. order:3,
> mode:0x4020
> 
> Order 3.  That's wanting 4K << 3, or 32K.
> 
> > [323570.289988] Normal: 1057*4kB 3870*8kB 99*16kB 0*32kB 0*64kB
> 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 36772kB
> 
> And from this line, we see that we have no pages larger than 16K
> available
> in the system, despite having 36MB of free memory.  IOW, your memory
> has
> become extremely fragmented.
> 
> We don't guaranttee that this doesn't happen - in fact, we explicitly
> tell
> people that memory fragmentation _does_ happen and we do _not_
> guarantee
> that allocations > order-0 will succeed.
> 
> From the backtrace, I guess you're using a network interface with a MTU
> larger than about 16K ?
<cut>

Physical network interface uses a MTU value of 1500. The ppp0 tunnel uses an MTU of 1400. Further note that I cannot reproduce this problem when transferring data with ftp directly over the physical network interface, nor when using cifs/smb over the ppp0 interface.

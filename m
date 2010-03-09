From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 9 Mar 2010 09:14:03 +0000
Subject: DMA using data buffer vmapped in kernel space
In-Reply-To: <10d816431003082345j5438d8cdi8ad72c4fa296b684@mail.gmail.com>
References: <201003042211.28569.thomas@koeller.dyndns.org>
	<20100304213634.GH13417@n2100.arm.linux.org.uk>
	<201003061407.12698.thomas@koeller.dyndns.org>
	<20100306193127.GA13262@n2100.arm.linux.org.uk>
	<10d816431003082345j5438d8cdi8ad72c4fa296b684@mail.gmail.com>
Message-ID: <20100309091403.GB5691@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 09, 2010 at 03:45:54PM +0800, Lin Mac wrote:
> I had encounter a similiar problem and I simply allocated a new
> buffer, copy the data, then DMA. It seems slow and stupid.
> 
> I'm wondering wether could I translate the vmap virt to phys(don't
> know how to yet), then use phys_to_virt to get the virt in
> direct-mapped memory region?
> 
> Is there other possible ways?

I think you need to talk to the firmware people... which is unfortunately
orphaned.

What you could do is prepare a patch to allow the firmware support to
export a scatterlist via the struct firmware, and then use that with
dma_map_sg().  Let's hope that the SPI interfaces support scatterlists.

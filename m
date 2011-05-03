From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 3 May 2011 09:44:37 +0100
Subject: dma_alloc_writecombine() and MAX_ORDER
In-Reply-To: <4DBF9FDC.6080400@linuxtv.org>
References: <4DBAB41D.7030705@linuxtv.org>
	<20110429142755.GS5126@n2100.arm.linux.org.uk>
	<4DBF9FDC.6080400@linuxtv.org>
Message-ID: <20110503084437.GK28001@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 03, 2011 at 08:25:32AM +0200, Michael Hunold wrote:
> Hello Russell,
> 
> on 04/29/2011 04:27 PM Russell King - ARM Linux said the following:
> > On Fri, Apr 29, 2011 at 02:50:37PM +0200, Michael Hunold wrote:
> 
> >> Now I have a new panel with a higher resolution and more bits-per-pixel.
> >> I want to use double-buffering with DirectFB and so my framebuffer size
> >> exceeds 4Mb.
> 
> > You could try this patch.  It steals the memory for the coherent and
> > writecombine memory at boot time, so MAX_ORDER no longer comes into the
> > problem.  You may need to define CONSISTENT_WC_SIZE and CONSISTENT_DMA_SIZE
> > appropriately to gain sufficient memory.  Note that the sum of those two
> > must be a multiple of 2MB, and individually must be a multiple of 1MB.
> 
> I really want to try this patch out, but unfortunately, I don't know to
> which tree I can apply it to. :-(

You may need 516295e (ARM: pgtable: add pud-level code) from a later
kernel as well then.

From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 12 Mar 2012 16:11:43 +0000
Subject: [PATCH v2 0/9] DMA engine cookie handling cleanups
In-Reply-To: <1331128466.24656.421.camel@vkoul-udesk3>
References: <20120306223321.GD15201@n2100.arm.linux.org.uk>
 <1331128466.24656.421.camel@vkoul-udesk3>
Message-ID: <20120312161143.GA10830@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 07, 2012 at 07:24:26PM +0530, Vinod Koul wrote:
> On Tue, 2012-03-06 at 22:33 +0000, Russell King - ARM Linux wrote:
> > [v2 - more or less same description.  Including lakml in cc for the full
> > set]
> > 
> > This patch series cleans up the handling of cookies in DMA engine drivers.
> > This is done by providing a set of inline library functions for common
> > tasks:
> > 
> > - moving the 'last completed cookie' into struct dma_chan - everyone
> >   has this in their driver private channel data structure
> > 
> > - consolidate allocation of cookies to DMA descriptors
> > 
> > - common way to update 'last completed cookie' value
> > 
> > - standard way to implement tx_status callback and update the residue
> > 
> > - consolidate initialization of cookies
> > 
> > - update implementations differing from the majority of DMA engine drivers
> >   to behave the same as the majority implementation in respect of cookies
> > 
> > What this means is that we get to the point where all DMA engine drivers
> > will hand out cookie value '2' as the first, and incrementing cookie
> > values up to INT_MAX, returning to cookie '1' as the next cookie.
> > 
> > Think of this patch series as round 1...  I am hoping over time that more
> > code can be consolidated between the DMA engine drivers and end up with a
> > consistent way to handle various common themes in DMA engine hardware
> > (like physical channel<->peripheral request signal selection.)
> Thanks Russell,
> 
> I have tested this on atom today, and as expected works flawlessly :)
> After all acks, I can merge or these can go thru your tree with my Ack.
> Either way is okay.
> 
> I applied the v2 on a branch and also rebased on top of slave-dma.next.
> There were few conflicts in imx-dma.c. Sacha, Javier, pls see that merge
> is right.
> 
> This branch (rmk_cookie_fixes2_rebased) is not yet pushed, as I am not
> able to connect to infradead.org, should be done when server is back.

Are you going to pick up Shawn Guo's tested-by for these patches, or are
we saying its too late for that now?

From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 5 Mar 2012 23:54:14 +0000
Subject: [PATCH 0/9] DMA engine cookie handling cleanups
In-Reply-To: <20120305201411.GA17791@n2100.arm.linux.org.uk>
References: <20120305201411.GA17791@n2100.arm.linux.org.uk>
Message-ID: <20120305235414.GB17370@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 05, 2012 at 08:14:11PM +0000, Russell King - ARM Linux wrote:
> This patch series cleans up the handling of cookies in DMA engine drivers.
> This is done by providing a set of inline library functions for common
> tasks:
> 
> - moving the 'last completed cookie' into struct dma_chan - everyone
>   has this in their driver private channel data structure
> 
> - consolidate allocation of cookies to DMA descriptors
> 
> - common way to update 'last completed cookie' value
> 
> - standard way to implement tx_status callback and update the residue
> 
> - consolidate initialization of cookies
> 
> - update implementations differing from the majority of DMA engine drivers
>   to behave the same as the majority implementation in respect of cookies
> 
> What this means is that we get to the point where all DMA engine drivers
> will hand out cookie value '2' as the first, and incrementing cookie
> values up to INT_MAX, returning to cookie '1' as the next cookie.
> 
> Think of this patch series as round 1...  I am hoping over time that more
> code can be consolidated between the DMA engine drivers and end up with a
> consistent way to handle various common themes in DMA engine hardware
> (like physical channel<->peripheral request signal selection.)
> 
> I've only build-tested this stuff on a few ARM configs, and my ability
> to run-test this stuff is even more limited by all the broken useless DMA
> engine hardware I have access to (mostly pl08x based) so having some
> tested-bys would be a great advantage.

Seems I'd misremembered what I'd done with this series.  I'll leave it
as-is for the time being if people want to provide review comments instead,
and I'll post v2 in the next couple of days.  (Quite a bit of this series
dates from August 2011...)

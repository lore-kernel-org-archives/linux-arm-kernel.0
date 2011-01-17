From: jamie@jamieiles.com (Jamie Iles)
Date: Mon, 17 Jan 2011 09:46:02 +0000
Subject: [RFC+CFT] Use word operations in bitops
In-Reply-To: <20110116121911.GB27542@n2100.arm.linux.org.uk>
References: <20110116121911.GB27542@n2100.arm.linux.org.uk>
Message-ID: <20110117094602.GA2622@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 16, 2011 at 12:19:11PM +0000, Russell King - ARM Linux wrote:
> XXX WARNING: bitops are used heavily by filesystem code: there be dragons XXX
> I strongly suggest you ensure you have a copy of your filesystems before
> trying this patch.
> 
> The patch below switches the bitops to use word loads/stores rather than
> byte operations - so that we can avoid using the ldrexb/strexb instructions
> which are only supported from ARMv6k and up.
[...]
> This does need a fair amount of testing before it can be merged, so I'd
> like to see a number of Tested-by's against this patch.  Please also
> indicate whether you tested on LE or BE or both, which filesystems, and
> whether they were read-only mounted or read-write mounted.

Hi Russell,

I've tested these on my picoxcell board (ARMv6K UP LE) with UBIFS, JFFS2 
and NFS all mounted rw and haven't seen any problems.  Our platforms 
aren't particulary FS intensive so I'll keep these patches applied to 
give them a bit more time.

Tested-by: Jamie Iles <jamie@jamieiles.com>

Jamie

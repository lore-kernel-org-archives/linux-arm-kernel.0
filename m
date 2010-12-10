From: gdavis@mvista.com (George G. Davis)
Date: Fri, 10 Dec 2010 00:44:04 -0500
Subject: [PATCH] ARM: V6 MPCore v6_dma_inv_range and v6_dma_flush_range
	RWFO fix
In-Reply-To: <4D015315.5070600@codeaurora.org>
References: <1290622059.3056.41.camel@e102109-lin.cambridge.arm.com>
	<20101124183936.GA18796@mvista.com>
	<AANLkTi=g7eHv9=L8G9CphLLLp6n-e_quDbuSW1LeSEqK@mail.gmail.com>
	<4D015315.5070600@codeaurora.org>
Message-ID: <20101210054404.GB13313@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 09, 2010 at 02:07:17PM -0800, Stephen Boyd wrote:
> On 12/09/2010 08:04 AM, Catalin Marinas wrote:
> > On 24 November 2010 18:39, Valentine Barshak <vbarshak@mvista.com> wrote:
> >> Updated according to the comments to avoid r/w outside the buffer and
> >> used byte r/w for the possible unaligned data. Seems to work fine.
> >>
> >> Cache ownership must be acqired by reading/writing data from the
> >> cache line to make cache operation have the desired effect on the
> >> SMP MPCore CPU. However, the ownership is never aquired in the
> >> v6_dma_inv_range function when cleaning the first line and
> >> flushing the last one, in case the address is not aligned
> >> to D_CACHE_LINE_SIZE boundary.
> >> Fix this by reading/writing data if needed, before performing
> >> cache operations.
> >> While at it, fix v6_dma_flush_range to prevent RWFO outside
> >> the buffer.
> >>
> >> Signed-off-by: Valentine Barshak <vbarshak@mvista.com>
> >> Signed-off-by: George G. Davis <gdavis@mvista.com>
> > I eventually found a bit of time to look at this. The patch looks fine to me:
> >
> > Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> 
> Is this also a stable candidate? At least it applies cleanly to .35

I'd say it makes sense to add "Cc: stable at kernel.org" to the commit
header before forwarding this to the ARM Linux kernel Patch Tracking
System [1] in this case.

--
Regards,
George

[1] http://www.arm.linux.org.uk/developer/patches/info.php

> 
> -- 
> Sent by an employee of the Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

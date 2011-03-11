From: will.deacon@arm.com (Will Deacon)
Date: Fri, 11 Mar 2011 16:56:43 -0000
Subject: [PATCH 1/7] ARM: irq: introduce entry and exit functions for
	chained handlers
In-Reply-To: <alpine.LFD.2.00.1103111731440.2787@localhost6.localdomain6>
References: <1299604405-12960-1-git-send-email-will.deacon@arm.com>
	<1299604405-12960-2-git-send-email-will.deacon@arm.com>
	<alpine.LFD.2.00.1103111731440.2787@localhost6.localdomain6>
Message-ID: <000601cbe00d$4d1acdb0$e7506910$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Tue, 8 Mar 2011, Will Deacon wrote:
> 
> > Some chained IRQ handlers are written to cope with primary chips of
> > potentially different flow types. Whether this a sensible thing to do
> > is a point of contention.
> 
> That wants a comment that these functions are only dealing with
> fasteoi and level type flow control.
> 
> Otherwise fine with me. Feel free to add my Acked-by.

Thanks Thomas, reworded as followed:

    ARM: irq: introduce entry and exit functions for chained handlers
    
    Some chained IRQ handlers are written to cope with primary chips of
    potentially different flow types. Whether this a sensible thing to do
    is a point of contention.
    
    This patch introduces entry/exit functions for chained handlers which
    infer the flow type of the primary chip as fasteoi or level-type by
    checking whether or not the ->irq_eoi function pointer is present and
    calling back to the primary chip as necessary. Other methods of flow
    control are not considered.

I'll add your Ack and put this (patch 1) in Russell's patch system next
week.

Will

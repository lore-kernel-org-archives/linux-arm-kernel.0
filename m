From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 21 Jul 2014 18:35:37 -0400 (EDT)
Subject: [PATCH 4/4] (RFC) X86: add IPI tracepoints
In-Reply-To: <1405887954.11927.5.camel@buesod1.americas.hpqcorp.net>
References: <1405660735-13408-1-git-send-email-nicolas.pitre@linaro.org>
 <1405660735-13408-5-git-send-email-nicolas.pitre@linaro.org>
 <1405887954.11927.5.camel@buesod1.americas.hpqcorp.net>
Message-ID: <alpine.LFD.2.11.1407211833330.3647@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 20 Jul 2014, Davidlohr Bueso wrote:

> On Fri, 2014-07-18 at 01:18 -0400, Nicolas Pitre wrote:
> > On X86 there are already tracepoints for IRQ vectors through which IPIs
> > are handled.  However this is highly X86 specific, and the IPI signaling
> > is not currently traced.
> > 
> > This is an attempt at adding generic IPI tracepoints to X86.
> 
> I welcome this, and fwiw have been trying out this patch. One thing I
> would like to see, but due to overhead would probably be better suited
> in userspace (trace-cmd, maybe?), is a more packed description of the
> IPI. Ie: unifying ipi_init and ipi_exit and show overall cost of the
> IPI.

That's best suited for the tool consuming the log in user space.  The 
same is done with IRQ events already.


Nicolas

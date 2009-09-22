From: brian@walsh.ws (Brian Walsh)
Date: Tue, 22 Sep 2009 18:02:19 -0400
Subject: ixp4xx dmabounce
In-Reply-To: <20090917215302.GA14939@n2100.arm.linux.org.uk>
References: <a104b22c0909171402x10c06d41oa5c78065a65836e1@mail.gmail.com>
	<20090917215302.GA14939@n2100.arm.linux.org.uk>
Message-ID: <a104b22c0909221502l621ec9e9ia02cb524479c4476@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 17, 2009 at 5:53 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
>
> On Thu, Sep 17, 2009 at 05:02:59PM -0400, Brian Walsh wrote:
> > Any ideas or suggestions?
>
> It's caused because we don't allow dma_free_coherent() to be called from
> IRQ context (which is reasonable because it needs to flush TLBs across
> all processors on SMP systems.)
>

I am not running on an SMP system so would this even be a problem?

>
> Unfortunately, with the DMA bounce code enabled, this function does get
> called from IRQ context, and so tends to spit out these warnings.
>
> I did have a patch which made dma_free_coherent() lazy, but it was
> reported that the suffered disk corruption (though it was never
> conclusive whether it was caused by the patch or not.) ?Here's an
> updated version of that patch.
>

I did not see any data rate improvement using this patch over just commenting
out the warning stack dump.? I am still seeing about half the data transfer rate
using the high speed ehci USB controller over the full speed ohci USB
controller.

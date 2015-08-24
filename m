From: will.deacon@arm.com (Will Deacon)
Date: Mon, 24 Aug 2015 10:22:56 +0100
Subject: [PATCH 0/2] arm64: ignore memory outside of the linear range
In-Reply-To: <CAKv+Gu-OQ4VyCqe=mEDOrrfAtAWTfRtAiqXMGSVjJxOH6xi4Ow@mail.gmail.com>
References: <1439890482-20798-1-git-send-email-ard.biesheuvel@linaro.org>
 <CY1PR0301MB0748FC71E6866C8AFACAAFF687780@CY1PR0301MB0748.namprd03.prod.outlook.com>
 <CAKv+Gu-OQ4VyCqe=mEDOrrfAtAWTfRtAiqXMGSVjJxOH6xi4Ow@mail.gmail.com>
Message-ID: <20150824092256.GA11262@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 24, 2015 at 09:00:43AM +0100, Ard Biesheuvel wrote:
> >> This is a followup to the single patch I posted on Aug 15th to ignore
> >> RAM that cannot be covered by the linear mapping. Instead of clipping
> >> the memory after the fact, this clips the memory before installing the
> >> regions into the memblock memory table.
> >>
> >> This is basically the approach that Mark Rutland suggested here
> >>
> >> http://article.gmane.org/gmane.linux.ports.arm.kernel/430239
> >>
> >> but modified to correctly consider the base of the kernel image as the
> >> start of the linear mapping.
> >>
> >> Ard Biesheuvel (2):
> >>   of/fdt: make memblock maximum physical address arch configurable
> >>   arm64: set MAX_MEMBLOCK_ADDR according to linear region size
> >>
> >>  arch/arm64/include/asm/memory.h |  8 ++++++++
> >>  drivers/of/fdt.c                | 12 +++++++-----
> >>  2 files changed, 15 insertions(+), 5 deletions(-)
> >
> > Tested on Freescale LS2085ARDB which has a split memory region
> > that triggers the bug.
> >
> > Tested-by: Stuart Yoder <stuart.yoder@freescale.com>
> >
> 
> Will you be picking up this series for v4.3? If so, do you need me to
> resend it with the tags added?

Sorry, I missed Rob's ack on the of/fdt.c change. I'll pick these up
later today, no need to resend.

Cheers,

Will

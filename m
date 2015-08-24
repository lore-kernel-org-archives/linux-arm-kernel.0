From: stuart.yoder@freescale.com (Stuart Yoder)
Date: Mon, 24 Aug 2015 22:34:54 +0000
Subject: [PATCH 0/2] arm64: ignore memory outside of the linear range
In-Reply-To: <20150824140828.GB20147@arm.com>
References: <1439890482-20798-1-git-send-email-ard.biesheuvel@linaro.org>
 <CY1PR0301MB0748FC71E6866C8AFACAAFF687780@CY1PR0301MB0748.namprd03.prod.outlook.com>
 <CAKv+Gu-OQ4VyCqe=mEDOrrfAtAWTfRtAiqXMGSVjJxOH6xi4Ow@mail.gmail.com>
 <20150824092256.GA11262@arm.com>
 <CY1PR0301MB0748EAE8103DDF771A37785787620@CY1PR0301MB0748.namprd03.prod.outlook.com>
 <20150824140828.GB20147@arm.com>
Message-ID: <CY1PR0301MB07481C5861695902A75CD23D87620@CY1PR0301MB0748.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Will Deacon [mailto:will.deacon at arm.com]
> Sent: Monday, August 24, 2015 9:08 AM
> To: Yoder Stuart-B08248
> Cc: Ard Biesheuvel; linux-arm-kernel at lists.infradead.org; Mark Rutland; Catalin Marinas; robh at kernel.org
> Subject: Re: [PATCH 0/2] arm64: ignore memory outside of the linear range
> 
> On Mon, Aug 24, 2015 at 02:58:26PM +0100, Stuart Yoder wrote:
> > > On Mon, Aug 24, 2015 at 09:00:43AM +0100, Ard Biesheuvel wrote:
> > > > >> This is a followup to the single patch I posted on Aug 15th to ignore
> > > > >> RAM that cannot be covered by the linear mapping. Instead of clipping
> > > > >> the memory after the fact, this clips the memory before installing the
> > > > >> regions into the memblock memory table.
> > > > >>
> > > > >> This is basically the approach that Mark Rutland suggested here
> > > > >>
> > > > >> http://article.gmane.org/gmane.linux.ports.arm.kernel/430239
> > > > >>
> > > > >> but modified to correctly consider the base of the kernel image as the
> > > > >> start of the linear mapping.
> > > > >>
> > > > >> Ard Biesheuvel (2):
> > > > >>   of/fdt: make memblock maximum physical address arch configurable
> > > > >>   arm64: set MAX_MEMBLOCK_ADDR according to linear region size
> > > > >>
> > > > >>  arch/arm64/include/asm/memory.h |  8 ++++++++
> > > > >>  drivers/of/fdt.c                | 12 +++++++-----
> > > > >>  2 files changed, 15 insertions(+), 5 deletions(-)
> > > > >
> > > > > Tested on Freescale LS2085ARDB which has a split memory region
> > > > > that triggers the bug.
> > > > >
> > > > > Tested-by: Stuart Yoder <stuart.yoder@freescale.com>
> > > > >
> > > >
> > > > Will you be picking up this series for v4.3? If so, do you need me to
> > > > resend it with the tags added?
> > >
> > > Sorry, I missed Rob's ack on the of/fdt.c change. I'll pick these up
> > > later today, no need to resend.
> >
> > Are we sending to stable as well?
> 
> I've already pushed the patch out without a Cc stable (it's not a
> regression afaict), so if you want it backported then you'll need to send
> it to stable separately.

Ok, was asking because of Catalin's previous comment:

 > Even though it is not a regression, I think it is a bug fix and it's
 > worth cc'ing stable (though we could push it after 4.3-rc1).

Ard, are you going to send to stable?

Thanks,
Stuart

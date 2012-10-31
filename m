From: michal.simek@xilinx.com (Michal Simek)
Date: Wed, 31 Oct 2012 08:43:35 +0000
Subject: [PATCH v4 4/5] ARM: annotate VMALLOC_END definition with _AC
In-Reply-To: <201210302222.15656.arnd@arndb.de>
References: <20121024200222.GA6713@beefymiracle.amer.corp.natinst.com>
 <20121024200431.GE6713@beefymiracle.amer.corp.natinst.com>
 <3c9e591c-a29f-446b-9256-bb23ff6d840d@TX2EHSMHS014.ehs.local>
 <201210302222.15656.arnd@arndb.de>
Message-ID: <29530110-f967-49c0-a2bc-d035d02da2a5@VA3EHSMHS020.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd at arndb.de]
> Sent: Tuesday, October 30, 2012 11:22 PM
> To: Michal Simek
> Cc: Josh Cartwright; arm at kernel.org; linux-kernel at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; John Linn; Nick Bowler; Russell King - ARM Linux
> Subject: Re: [PATCH v4 4/5] ARM: annotate VMALLOC_END definition with _AC
>
> On Saturday 27 October 2012, Michal Simek wrote:
> > > diff --git a/arch/arm/include/asm/pgtable.h
> > > b/arch/arm/include/asm/pgtable.h index 08c1231..72904a2 100644
> > > --- a/arch/arm/include/asm/pgtable.h
> > > +++ b/arch/arm/include/asm/pgtable.h
> > > @@ -40,7 +40,7 @@
> > >   */
> > >  #define VMALLOC_OFFSET               (8*1024*1024)
> > >  #define VMALLOC_START                (((unsigned long)high_memory +
> > > VMALLOC_OFFSET) & ~(VMALLOC_OFFSET-1))
> > > -#define VMALLOC_END          0xff000000UL
> > > +#define VMALLOC_END          _AC(0xff000000,UL)
> >
> > This shouldn't be the part of this series but should go to mainline through
> different tree.
> > Arnd, Olof: Can you take this patch to your arm-soc tree?
> >
> > I don't think it is a good workstyle to propose it to mainline through zynq soc
> tree.
> > What do you think?
>
> The arm-soc tree is not the right place either, this is architecture code which is in
> Russell's domain. I would suggest getting an Ack from Russell if he's ok with it
> and then merging it together with your other changes into arm-soc.

That's what I thought too.
Not sure if Josh wants to push this to mainline.

Thanks,
Michal




This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.

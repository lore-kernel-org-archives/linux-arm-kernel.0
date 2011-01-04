From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 04 Jan 2011 12:54:15 -0500 (EST)
Subject: [PATCH 2/4] ARM: make PHYS_OFFSET actually variable
In-Reply-To: <20110104123049.GC16671@n2100.arm.linux.org.uk>
References: <1294129208-15201-1-git-send-email-nico@fluxnic.net>
	<1294129208-15201-3-git-send-email-nico@fluxnic.net>
	<20110104123049.GC16671@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1101041251500.22191@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 4 Jan 2011, Russell King - ARM Linux wrote:

> On Tue, Jan 04, 2011 at 03:20:06AM -0500, Nicolas Pitre wrote:
> > diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> > index 336f14e..7502bc1 100644
> > --- a/arch/arm/kernel/setup.c
> > +++ b/arch/arm/kernel/setup.c
> > @@ -703,8 +703,10 @@ static struct init_tags {
> >  } init_tags __initdata = {
> >  	{ tag_size(tag_core), ATAG_CORE },
> >  	{ 1, PAGE_SIZE, 0xff },
> > +#ifndef CONFIG_ARM_PATCH_PHYS_VIRT
> >  	{ tag_size(tag_mem32), ATAG_MEM },
> >  	{ MEM_SIZE, PHYS_OFFSET },
> > +#endif
> 
> Removing the definition is not really on - it's there as a fallback and
> removing fallbacks is not a good idea unless you can prove beyond doubt
> that it'll never be used.
> 
> As that depends on the boot loader, it's something that can never be
> proven.  So, arrange for it to be initialized at runtime, just like I
> will be doing in my revised version I'm working on which I detailed in
> a previous email.

Agreed.

I'll wait for that revised version before working on this further.


Nicolas

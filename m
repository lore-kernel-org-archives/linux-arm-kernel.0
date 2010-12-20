From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 20 Dec 2010 17:08:49 +0000
Subject: [PATCH v4 3/6] ARM: U8500 core machine support
In-Reply-To: <C832F8F5D375BD43BFA11E82E0FE9FE00829A2FDB7@EXDCVYMBSTM005.EQ1STM.local>
References: <1259279756.13327.72.camel@vinay-desktop>
	<20101219110913.GA23979@n2100.arm.linux.org.uk>
	<C832F8F5D375BD43BFA11E82E0FE9FE00829A2FDB7@EXDCVYMBSTM005.EQ1STM.local>
Message-ID: <20101220170849.GG28157@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 20, 2010 at 05:47:25AM +0100, Srinidhi KASAGAR wrote:
> > -----Original Message-----
> > From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
> > Sent: Sunday, December 19, 2010 4:39 PM
> > To: Srinidhi KASAGAR
> > Cc: linux-arm-kernel at lists.infradead.org; STEricsson_nomadik_linux;
> > Andrea GALLO; rubini at unipv.it
> > Subject: Re: [PATCH v4 3/6] ARM: U8500 core machine support
> > 
> > ... going back to this patch...
> > 
> > On Fri, Nov 27, 2009 at 05:25:56AM +0530, srinidhi kasagar wrote:
> > > +/*
> > > + * U8500 specific entry point for secondary CPUs.
> > > + */
> > > +ENTRY(u8500_secondary_startup)
> > > +	mrc	p15, 0, r0, c0, c0, 5
> > > +	and	r0, r0, #15
> > > +	adr	r4, 1f
> > > +	ldmia	r4, {r5, r6}
> > > +	sub	r4, r4, r5
> > > +	add	r6, r6, r4
> > > +	dsb
> > 
> > Can you please explain why you added a dsb here, whereas most other
> > platforms don't require it?
> 
> No reason, you can safely ignore this. I can send a patch to remove this
> if you need.

It would be better to have all the pen_release implementations without
spurious differences when the differences aren't necessary.

So, yes please.

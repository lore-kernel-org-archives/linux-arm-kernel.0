From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 27 Oct 2010 21:20:18 +0100
Subject: Is ep93xx support broken in linux-next?
In-Reply-To: <20101026132235.GD15333@gw.healthdatacare.com>
References: <1288094199.2098.26.camel@r60e>
	<20101026125050.GB15333@gw.healthdatacare.com>
	<20101026125841.GC15333@gw.healthdatacare.com>
	<1288099206.2098.27.camel@r60e>
	<20101026132235.GD15333@gw.healthdatacare.com>
Message-ID: <20101027202018.GB24573@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 26, 2010 at 04:22:35PM +0300, Mika Westerberg wrote:
> On Tue, Oct 26, 2010 at 05:20:06PM +0400, Alexander Sverdlin wrote:
> > On Tue, 2010-10-26 at 15:58 +0300, Mika Westerberg wrote:
> > > On Tue, Oct 26, 2010 at 03:50:51PM +0300, Mika Westerberg wrote:
> > > [...]
> > > >  
> > > >  /*
> > > > + *	flush_icache_all()
> > > > + *
> > > > + *	Unconditionally clean and invalidate the entire icache.
> > > > + */
> > > > +ENTRY(fa_flush_icache_all)
> > > > +	mov	r0, #0
> > > > +	mcr	p15, 0, ip, c7, c5, 0		@ invalidate I cache
> > > 
> > > Obviously the register should be r0 instead of ip.
> > 
> > Only one occurrence should be changed?
> 
> No, all of them. But with ep93xx you can just change it
> from arm920_flush_icache_all().

Is there an updated patch ready?

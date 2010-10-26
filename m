From: alex@gai.ru (Alexander Sverdlin)
Date: Tue, 26 Oct 2010 18:48:44 +0400
Subject: Is ep93xx support broken in linux-next?
In-Reply-To: <20101026132235.GD15333@gw.healthdatacare.com>
References: <1288094199.2098.26.camel@r60e>
	<20101026125050.GB15333@gw.healthdatacare.com>
	<20101026125841.GC15333@gw.healthdatacare.com>
	<1288099206.2098.27.camel@r60e>
	<20101026132235.GD15333@gw.healthdatacare.com>
Message-ID: <1288104524.2098.30.camel@r60e>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tue, 2010-10-26 at 16:22 +0300, Mika Westerberg wrote:
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

It makes linux-next-20101025 work fine for EDB9302-based board.
But there seems to be another issue with linux-next-20101026, some
problem with RedBoot partition handling...

Alexander.

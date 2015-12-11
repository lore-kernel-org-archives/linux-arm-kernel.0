From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 11 Dec 2015 23:48:45 +0100
Subject: [PATCH] ARM: Runtime patch udiv/sdiv instructions into
 __aeabi_{u}idiv()
In-Reply-To: <alpine.LFD.2.20.1512111652330.26920@knanqh.ubzr>
References: <alpine.LFD.2.20.1512110105450.26920@knanqh.ubzr>
 <1887582.W42jA1d2lP@wuerfel>
 <alpine.LFD.2.20.1512111652330.26920@knanqh.ubzr>
Message-ID: <5144827.9Y9WomU3im@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 11 December 2015 17:00:50 Nicolas Pitre wrote:
> You seem to have a good grasp of the problem space. I'd suggest you make 
> a patch!  ;-)

Yes, I can do that once all the ARMv6/v7 multiplatform work is done, that
should at least reduce the number of special cases.

> > > > #ifdef CONFIG_CPU_PJ4B
> > > >         .type   __v7_pj4b_proc_info, #object
> > > > __v7_pj4b_proc_info:
> > > >         .long   0x560f5800
> > > >         .long   0xff0fff00
> > > >         __v7_proc __v7_pj4b_proc_info, __v7_pj4b_setup, proc_fns = pj4b_processor_functions
> > > >         .size   __v7_pj4b_proc_info, . - __v7_pj4b_proc_info
> > > > #endif
> > > > 
> > > > 
> > > > Can someone have a look and tell me that I'm wrong when I read this
> > > > as matching both PJ4 and PJ4B (and PJ4B-MP)?
> > > > 
> > > > Either I'm misreading this, or we do the wrong thing in configurations
> > > > that include both PJ4B (berlin, mvebu) and PJ4 (MMP2/dove).
> > > 
> > > I don't have the relevant documentation to validate it.  And I'd prefer 
> > > if this was sorted out in a separate patch.  Maybe I should just drop 
> > > the PJ4 variants from this patch for now.
> > 
> > To clarify: that point had nothing to do with your patch, I just think
> > I found an existing kernel bug that will cause pj4b_processor_functions
> > to be used on PJ4 (Dove, MMP2) in a kernel that includes both PJ4 and
> > PJ4B (Armada 370/XP, Berlin).
> 
> OK. I'd suggest starting another thread about this to get the right 
> people's attention.

I've done a preliminary patch now, will send that out.

	Arnd

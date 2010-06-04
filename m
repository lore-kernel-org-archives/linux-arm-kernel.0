From: marek.vasut@gmail.com (Marek Vasut)
Date: Fri, 4 Jun 2010 03:53:35 +0200
Subject: Heads up: Linus plans to kill ARM defconfigs
In-Reply-To: <201006040350.36944.marek.vasut@gmail.com>
References: <20100603192459.GA9169@n2100.arm.linux.org.uk>
	<201006040337.10593.marek.vasut@gmail.com>
	<201006040350.36944.marek.vasut@gmail.com>
Message-ID: <201006040353.35816.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne P? 4. ?ervna 2010 03:50:36 Marek Vasut napsal(a):
> Dne P? 4. ?ervna 2010 03:37:10 Marek Vasut napsal(a):
> > Dne P? 4. ?ervna 2010 03:35:28 Eric Miao napsal(a):
> > > On Fri, Jun 4, 2010 at 9:16 AM, Ryan Mallon <ryan@bluewatersys.com> wrote:
> > > > Marek Vasut wrote:
> > > >> Dne P? 4. ?ervna 2010 01:33:35 Ryan Mallon napsal(a):
> > > >>> Nicolas Pitre wrote:
> > > >>>> On Fri, 4 Jun 2010, Ryan Mallon wrote:
> > > >>>>> Is it worth being a bit proactive and getting rid of some of them
> > > >>>>> in advance? Things like spear3[012]0_defconfig are basically
> > > >>>>> identically except for the board type. Combining all three of
> > > >>>>> those would remove 1500 lines of code.
> > > >>>> 
> > > >>>> Please go ahead with a patch.
> > > >>> 
> > > >>> Hmm, not as easy as I thought. The three boards cannot be built
> > > >>> into a single kernel since the
> > > >>> arch/arm/mach-spear3xx/spear3[012]0.c files all extern a bunch of
> > > >>> structs which have naming conflicts.
> > > >>> 
> > > >>> It does look possible to rewrite that code so that all three boards
> > > >>> can be built into a single kernel. I can try and put together a
> > > >>> patch, but I don't have any hardware to test with.
> > > >>> 
> > > >>> The at91 is actually in a similar state, where only one of the
> > > >>> at91sam9260, at91sam9g45, etc can be selected. Again, it should be
> > > >>> possible to rework the code so that most of the different cpus can
> > > >>> be built into a single kernel. I'm sure other mach's are in a
> > > >>> simliar state. Fixing these where possible would allow us to have
> > > >>> single defconfigs per mach directory and reduce code churn, which
> > > >>> is what Linus is really complaining about.
> > > >> 
> > > >> I just tested, PXA (mach-pxa) probably can be compiled into single
> > > >> kernel supporting all the boards.
> > > > 
> > > > Yes, IIRC Russell and Eric did a huge amount of work to get pxa into
> > > > that state.
> > > > 
> > > > ryan at okiwi:configs$ grep "ARCH_PXA=y" * | wc -l
> > > > 25
> > > > 
> > > > Can we remove/combine some of those?
> > > 
> > > Definitely. In the end of the day, I would like to see pxa_defconfig
> > > only. But at the moment, I need every board maintainer to review their
> > > defconfig and combine them as much as possible. E.g.
> > > 
> > > palmte_defconfig   palmtt_defconfig   palmz71_defconfig
> > > palmz72_defconfig
> 
> OMAP: palmte_defconfig, palmtt_defconfig, palmz71_defconfig

Ok, making them into one is compile tested. I'd be for calling it a 
"palmomap_defconfig". Or maybe is there a plan to put whole OMAP1 into a single 
defconfig ?

> PXA: palmz72_defconfig ... the rest of palmxx_defconfig
> 
> Sorry about the confusion
> 
> > This is OMAP stuff, not PXA. But yeah, these could be combined. I don't
> > have these devices available at the moment (and it might be a problem
> > getting them into operational state).
> > 
> > > I'd guess can simply combine into one. (Marek, feel free to do it)
> > > 
> > > I'd more like a step to step work instead of a brutely removal of all
> > > defconfig, not sure if Linus is going to buy in.
> > > 
> > > For those sub-arch which cannot simply compile a single kernel for
> > > multiple boards, s5p* as previously mentioned, I suggest not to
> > > introduce any new defconfig until the problem is solved.
> > > 
> > > Also, we are now working on a single kernel for multiple sub-arch (at
> > > least what Nicolas and I am doing now, and welcome to join us). It's
> > > tough (the way to handle different phys_offset is only the tip of the
> > > iceberg) and seems now more and more necessary. so hopefully by the end
> > > of the day, we may possible end up with only very few defconfig.
> > 
> > How long is your day now ?

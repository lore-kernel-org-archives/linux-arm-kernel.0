From: tony@atomide.com (Tony Lindgren)
Date: Fri, 28 Jan 2011 08:51:58 -0800
Subject: [PATCH RESEND v8 3/7] omap: gpmc: enable irq mode in gpmc
In-Reply-To: <2A3DCF3DA181AD40BDE86A3150B27B6B036AA2EC2E@dbde02.ent.ti.com>
References: <1295443503-14515-1-git-send-email-s-ghorai@ti.com>
	<1295443503-14515-4-git-send-email-s-ghorai@ti.com>
	<20110121184020.GD11678@atomide.com>
	<2A3DCF3DA181AD40BDE86A3150B27B6B036A8DB549@dbde02.ent.ti.com>
	<20110125165735.GL13589@atomide.com>
	<2A3DCF3DA181AD40BDE86A3150B27B6B036AA2EC2E@dbde02.ent.ti.com>
Message-ID: <20110128165158.GU23412@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Ghorai, Sukumar <s-ghorai@ti.com> [110128 00:14]:
> 
> 
> > -----Original Message-----
> > From: Tony Lindgren [mailto:tony at atomide.com]
> > Sent: Tuesday, January 25, 2011 10:28 PM
> > To: Ghorai, Sukumar
> > Cc: linux-omap at vger.kernel.org; linux-mtd at lists.infradead.org; linux-arm-
> > kernel at lists.infradead.org
> > Subject: Re: [PATCH RESEND v8 3/7] omap: gpmc: enable irq mode in gpmc
> > 
> > * Ghorai, Sukumar <s-ghorai@ti.com> [110122 09:53]:
> > > >
> > > > I think I've commented on this before, but why don't you make
> > gpmc_init
> > > > a subsys_initcall? There should be no reason to call this earlier.
> > > > If something does not work because of that, then that issue must be
> > > > fixed.
> > >
> > > [Ghorai] You suggested the same in previous v5 and v6; and I mentioned
> > > the issues [1] that - nand_init()called before
> > subsys_initcall(gpmc_init);
> > > Let me know if I am missing anything again.
> > 
> > There should not be any need to call nand_init early either. We want
> > to initialize as much as possible late so we have proper console
> > error messages.
> 
> [Ghorai] thanks...
> changed to postcore_initcall() and it solved the problem I mentioned earlier. And it simplifies the overall modification in different board files.
> postcore_initcall(gpmc_init);

OK great. I will check the order of initcalls anyways over next few
weeks, so whatever works for the initcall is fine for now.

Regards,

Tony

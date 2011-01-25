From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 25 Jan 2011 12:17:45 +0000
Subject: [PATCH 3/5] ARM: twd: Add context save restore support
In-Reply-To: <8784651c2ea55ec67dabca6037034970@mail.gmail.com>
References: <1295859080-15259-1-git-send-email-santosh.shilimkar@ti.com>
	<1295859080-15259-4-git-send-email-santosh.shilimkar@ti.com>
	<20110124110609.GJ16202@n2100.arm.linux.org.uk>
	<20110124111114.GA19409@n2100.arm.linux.org.uk>
	<AANLkTikLDamkp9TgnWRESyx4=698D4NXP=W_M9=abfax@mail.gmail.com>
	<20110125112946.GA13300@n2100.arm.linux.org.uk>
	<b4c0d6db681c3fcfaf5d6f39d1022bb7@mail.gmail.com>
	<20110125114848.GC13300@n2100.arm.linux.org.uk>
	<8784651c2ea55ec67dabca6037034970@mail.gmail.com>
Message-ID: <20110125121745.GE13300@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 25, 2011 at 05:38:49PM +0530, Santosh Shilimkar wrote:
> Looping Thomas G
> > -----Original Message-----
> > From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
> > Sent: Tuesday, January 25, 2011 5:19 PM
> > To: Santosh Shilimkar
> > Cc: Colin Cross; catalin.marinas at arm.com;
> > linus.ml.walleij at gmail.com; linux-omap at vger.kernel.org; linux-arm-
> > kernel at lists.infradead.org
> > Subject: Re: [PATCH 3/5] ARM: twd: Add context save restore support
> >
> > On Tue, Jan 25, 2011 at 05:10:37PM +0530, Santosh Shilimkar wrote:
> > > As I was suspecting the one shot mode wouldn't work it. Collin
> > > just confirmed it.
> > > To make it fully work it needs control register save restore.
> > > And that can be managed within TWD library so that every platform
> > > doesn't have to bother of calling it from their idle code.
> > >
> > > Do you prefer that as a separate patch or I can post a new version
> > > in which can add your fix + per cpu control register shadowing ?
> >
> > I said earlier:
> > | The next question is can we teach the generic time infrastructure
> > about
> > | this so we don't have to modify every clock event driver for it?
> > We
> > | really need to get away from having this kind of knowledge buried
> > down
> > | in the lowest levels of every driver.
> >
> > IOW, if we go into a PM idle mode, when we come back out we need to
> > call clockevent set_mode to ensure that the control register is
> > properly
> > reset.  I don't think its right to have this kind of knowledge
> > buried
> > in each and every clockevent driver.
> May be Thomas can comment on this.

He was already added on my previous email... we're going round in circles.

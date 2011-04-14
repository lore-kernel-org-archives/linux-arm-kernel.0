From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 14 Apr 2011 13:02:09 +0100
Subject: Status of arch/arm in linux-next
In-Reply-To: <20110414110854.GF29938@atomide.com>
References: <20110414094447.GA1611@n2100.arm.linux.org.uk>
	<20110414110854.GF29938@atomide.com>
Message-ID: <20110414120209.GG1611@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 14, 2011 at 02:08:54PM +0300, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [110414 12:42]:
> > This morning, I looked at linux-next to find out how arch/arm is doing
> > for the next merge window.
> > 
> > $ git diff -C --cumulative v2.6.39-rc1... arch
> >   19.7% arch/arm/mach-imx/
> >   19.2% arch/arm/mach-mx3/
> >    3.4% arch/arm/mach-mxc91231/
> >   18.1% arch/arm/mach-ux500/
> >   74.1% arch/arm/
> >    3.2% arch/m68k/
> >    4.0% arch/mips/lantiq/
> >    6.9% arch/mips/
> >    3.1% arch/x86/kvm/
> >    7.6% arch/x86/
> >  100.0% arch/
> > $ git diff -C --cumulative v2.6.39-rc1... arch/arm
> >    4.7% arch/arm/mach-imx/
> >    5.9% arch/arm/mach-msm/
> >    6.3% arch/arm/mach-mx3/
> >    8.8% arch/arm/mach-mxc91231/
> >    7.6% arch/arm/mach-ux500/include/mach/
> >   46.1% arch/arm/mach-ux500/
> >    3.6% arch/arm/mach-zynq/
> >    5.9% arch/arm/plat-mxc/include/mach/
> >    7.3% arch/arm/plat-mxc/
> >  100.0% arch/arm/
> > $ git diff -C --shortstat v2.6.39-rc1... arch/arm
> >  450 files changed, 11973 insertions(+), 5736 deletions(-)
> > 
> > Note that with --cumulative, the %age given includes all child directories
> > (so the 74% for arch/arm includes everything below it).
> > 
> > So, almost 75% of changes in arch are down to arch/arm.  For arch/arm,
> > there's 6k new lines introduced - so there's a significant amount of new
> > work there.
> > 
> > Folk may want to consider that we're three weeks from Linus' rant, and
> > there's little sign of the situation changing.  It looks to me from
> > these statistics that it's business as usual.
> > 
> > Please take a moment to consider how Linus will react to this at the
> > next merge window.
> 
> It's going to take some time before the consolidated code starts
> being available.. And until we have something available, we all
> should aim for negative diffstat.

I think we've already lost any hope of a negative diffstat - with 6k new
lines, we will need a heck of a lot of consolidation to counter that.

The only thing which I've seen any work being put into is some of the
GPIO code - which will be lost in the noise in much the same way that
my ARM platform consolidation and deletion of two machine classes in
the last merge window was.  That resulted in the deletion of around 10k
lines from the kernel as a whole, or 4.5k lines from arch/arm.

Some people are believing that Linus' complaint is about the core ARM
code rather than the platform specific code which is the problem.

We need significant amounts of effort to reverse this - and the more new
stuff that appears in peoples trees (and therefore linux-next) the bigger
problem we have to convince Linus that we're taking him seriously.

So, I think we've already lost any hope of making Linus happy for the
next merge window.  I wish I'm wrong on that, but I don't think so.

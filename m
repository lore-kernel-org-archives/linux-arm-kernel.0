From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 14 Apr 2015 11:34:56 +0200
Subject: Two new breakages since Thursday
In-Reply-To: <20150414092612.GT12732@n2100.arm.linux.org.uk>
References: <20150405080645.GE13898@n2100.arm.linux.org.uk>
 <201504140041.34509.arnd@arndb.de>
 <20150414092612.GT12732@n2100.arm.linux.org.uk>
Message-ID: <3997405.uu5IlQn29B@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 14 April 2015 10:26:12 Russell King - ARM Linux wrote:
> On Tue, Apr 14, 2015 at 12:41:34AM +0200, Arnd Bergmann wrote:
> > On Monday 13 April 2015, Yingjoe Chen wrote:
> > > 
> > > On Sat, 2015-04-11 at 10:00 +0100, Russell King - ARM Linux wrote:
> > > > And almost a week later, and most of these are still present.
> > > > 
> > > > Given that the merge window is potentially opening on Sunday, this
> > > > is very poor, because it means that we've had a week of failing
> > > > builds in the week before the merge window - the week where we
> > > > should be stabilising the code and getting it ready for submission
> > > > to Linus.
> > > > 
> > > > Right now, arm-soc is NOT ready for submission to Linus.
> > > > 
> > > > Please fix this as a top priority.
> > > > 
> > > > On Sun, Apr 05, 2015 at 09:06:45AM +0100, Russell King - ARM Linux wrote:
> > > > > Two new breakages have appeared since Thursday.  The first affects both
> > > > > ARM and ARM64 builds (a missing file), the second only ARM builds.
> > > > > 
> > > > > arch/arm64/boot/dts/mediatek/mt8173-pinfunc.h:18:40: fatal error: dt-bindings/pinctrl/mt65xx.h: No such file or directory
> > > > > arch/arm/boot/dts/mt8135-pinfunc.h:18:40: fatal error: dt-bindings/pinctrl/mt65xx.h: No such file or directory
> > > > > arch/arm/mach-at91/pm_suspend.S:143: Error: selected processor does not support ARM mode `dsb'
> > > 
> > > Hi Arnd/Olof,
> > > 
> > > The mediatek part is due to merge dependency in pinctrl driver. It is
> > > discussed in
> > > http://lists.infradead.org/pipermail/linux-arm-kernel/2015-April/336258.html
> > > 
> > > I thought we already decided to revert DT node in arm-soc tree for 4.1.
> > > What should we do next?
> > 
> > I've finally managed to find my way through the email backlog from being
> > away for three weeks and got to this one now. Patch is reverted in next/dt now.
> > 
> > Sorry about the delay in processing this.
> 
> Well, if this is now gone, there's still the issue of the AT91 breakage
> that also needs to be fixed which is still there when I pulled arm-soc
> last night.  What's happening there?
> 

I managed to catch up with my email last night and pulled in these two fixes
as well as a number of others that we had neglected over the last two weeks.

I found one new regression with the overnight build tests in a branch I pulled
in as 'next/late' from Tony, and backed that out now. I'll wait for you and
Stephen Rothwell (who also reported these issues) to confirm that it's ok
now and we'll hopefully be ready to send pull requests by the end of the
week.

	Arnd

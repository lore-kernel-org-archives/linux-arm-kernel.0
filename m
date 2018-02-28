From: tony@atomide.com (Tony Lindgren)
Date: Wed, 28 Feb 2018 14:11:15 -0800
Subject: [PATCH 1/6] clocksource: timer-ti-dm: Make unexported functions
 static
In-Reply-To: <20180227192354.GG5448@atomide.com>
References: <20180223101254.GA5746@lenoch> <20180223101346.GB5746@lenoch>
 <20180227180641.GE5448@atomide.com> <20180227190752.GC1961@lenoch>
 <20180227192354.GG5448@atomide.com>
Message-ID: <20180228221115.GL5448@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [180227 19:24]:
> * Ladislav Michl <ladis@linux-mips.org> [180227 19:09]:
> > On Tue, Feb 27, 2018 at 10:06:41AM -0800, Tony Lindgren wrote:
> > > * Ladislav Michl <ladis@linux-mips.org> [180223 10:14]:
> > > > As dmtimer no longer exports functions, make those previously
> > > > exported static (this requires few functions to be moved around
> > > > as their prototypes were deleted).
> > > 
> > > Looks like this one fails to build with omap1_defconfig:
> > > 
> > > drivers/clocksource/timer-ti-dm.c:935:14: error:
> > > 'omap_dm_timer_get_fclk' undeclared here 
> > 
> > Umm, it compiled fine on top of previous versions, so I didn't bother
> > to retest. I'm sorry about it.
> > 
> > > Other than that the first three patches seem like nice
> > > clean-up :)
> > 
> > So are you okay with sending those separately as cleanup with above
> > issue fixed?
> 
> Yeah seems like those first three are suitable for applying
> on top of the patches in omap-for-v4.17/timer :)

I've now applied your v2 of patch 1 and patches 2 and 3 of
this series into omap-for-v4.17/timer.

Thanks,

Tony

From: ladis@linux-mips.org (Ladislav Michl)
Date: Tue, 27 Feb 2018 20:07:52 +0100
Subject: [PATCH 1/6] clocksource: timer-ti-dm: Make unexported functions
 static
In-Reply-To: <20180227180641.GE5448@atomide.com>
References: <20180223101254.GA5746@lenoch> <20180223101346.GB5746@lenoch>
 <20180227180641.GE5448@atomide.com>
Message-ID: <20180227190752.GC1961@lenoch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 27, 2018 at 10:06:41AM -0800, Tony Lindgren wrote:
> * Ladislav Michl <ladis@linux-mips.org> [180223 10:14]:
> > As dmtimer no longer exports functions, make those previously
> > exported static (this requires few functions to be moved around
> > as their prototypes were deleted).
> 
> Looks like this one fails to build with omap1_defconfig:
> 
> drivers/clocksource/timer-ti-dm.c:935:14: error:
> 'omap_dm_timer_get_fclk' undeclared here 

Umm, it compiled fine on top of previous versions, so I didn't bother
to retest. I'm sorry about it.

> Other than that the first three patches seem like nice
> clean-up :)

So are you okay with sending those separately as cleanup with above
issue fixed?

But to be honest, I'm more interested how to do the last two patches
right ;-)

> Regards,
> 
> Tony

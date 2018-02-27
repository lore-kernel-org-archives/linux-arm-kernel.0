From: tony@atomide.com (Tony Lindgren)
Date: Tue, 27 Feb 2018 10:06:41 -0800
Subject: [PATCH 1/6] clocksource: timer-ti-dm: Make unexported functions
 static
In-Reply-To: <20180223101346.GB5746@lenoch>
References: <20180223101254.GA5746@lenoch>
 <20180223101346.GB5746@lenoch>
Message-ID: <20180227180641.GE5448@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Ladislav Michl <ladis@linux-mips.org> [180223 10:14]:
> As dmtimer no longer exports functions, make those previously
> exported static (this requires few functions to be moved around
> as their prototypes were deleted).

Looks like this one fails to build with omap1_defconfig:

drivers/clocksource/timer-ti-dm.c:935:14: error:
'omap_dm_timer_get_fclk' undeclared here 

Other than that the first three patches seem like nice
clean-up :)

Regards,

Tony

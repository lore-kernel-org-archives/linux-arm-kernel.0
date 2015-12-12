From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 12 Dec 2015 01:30:17 +0100
Subject: [GIT PULL 1/3] rockchip soc changes for 4.5
In-Reply-To: <1936935.FVZdWRYuBf@diego>
References: <1936935.FVZdWRYuBf@diego>
Message-ID: <1650675.1PTvAK3nr8@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 05 December 2015 01:53:38 Heiko St?bner wrote:
> SMP special case for the rk3036 and making sure the arch-timer
> supply is enabled, similar to the rk3288.

That is a rather ugly hack, I'd prefer if this could be done cleaner
rather than duplicated into another place.

Sorry for not seeing this earlier. Can you replace the hardcoded 
RK3036_TIMER_PHYS and RK3288_TIMER6_7_PHYS constants with a DT
lookup, to make it somewhat less hacky?

	Arnd

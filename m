From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 05 Sep 2014 23:39:17 +0200
Subject: [GIT PULL] at91: drivers for 3.18 #2
In-Reply-To: <201409052325.11709.arnd@arndb.de>
References: <1409934969-11584-1-git-send-email-nicolas.ferre@atmel.com>
 <201409052325.11709.arnd@arndb.de>
Message-ID: <4063119.0hOqm7cf3h@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 05 September 2014 23:25:11 Arnd Bergmann wrote:
> On Friday 05 September 2014, Nicolas Ferre wrote:
> > Arnd, Olof, Kevin,
> > 
> > This pull-request is focused on the work that Maxime did for migrating our timer
> > (PIT) to the clocksource sub-system. A big cleanup happened which allows us to
> > be even closer to the point when we have only the bare minimum in our formerly
> > crowded mach-at91 directory.
> > 
> > This pull-request goes on top of the "drivers" one already sent to you on Sept.
> > 01st.
> 
> Hmm, I'm not too happy to see more uses of early_platform_*, I was hoping
> we could kill that off in the long run. This is only used for the legacy
> board files, not for DT, right?
> 
> Do you have a timeline for getting rid of the board files completely?
> 

I've looked more closely, and I think a good way to solve this would be
to revert or remove "ARM: at91: PIT: Convert to an early_platform_device",
and add declarations for the two global functions to
include/clocksource/at91.h and passing the interrupt number as an argument
to at91sam926x_pit_init.

I understand it's not the goal you had in mind here, but it's far simpler
and it gives me hope that we can eventually kill that early platform
code.

	Arnd

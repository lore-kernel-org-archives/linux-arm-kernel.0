From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 08 Sep 2014 11:52:35 +0200
Subject: [GIT PULL] at91: drivers for 3.18 #2
In-Reply-To: <20140908092642.GB20883@lukather>
References: <1409934969-11584-1-git-send-email-nicolas.ferre@atmel.com>
 <201409052325.11709.arnd@arndb.de> <20140908092642.GB20883@lukather>
Message-ID: <26517543.McM8Q5P0vn@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 08 September 2014 11:26:42 Maxime Ripard wrote:
> On Fri, Sep 05, 2014 at 11:25:11PM +0200, Arnd Bergmann wrote:
> > On Friday 05 September 2014, Nicolas Ferre wrote:
> > > Arnd, Olof, Kevin,
> > > 
> > > This pull-request is focused on the work that Maxime did for migrating our timer
> > > (PIT) to the clocksource sub-system. A big cleanup happened which allows us to
> > > be even closer to the point when we have only the bare minimum in our formerly
> > > crowded mach-at91 directory.
> > > 
> > > This pull-request goes on top of the "drivers" one already sent to you on Sept.
> > > 01st.
> > 
> > Hmm, I'm not too happy to see more uses of early_platform_*, I was hoping
> > we could kill that off in the long run. This is only used for the legacy
> > board files, not for DT, right?
> 
> Yes, the DT uses the usual CLOCKSOURCE_OF_DECLARE mechanism.
> 
> I wasn't aware that early_platform drivers were in the killzone, but
> I'm definitely aware that global custom exported functions are, hence
> why I went this way.

I don't think it has been discussed much on the mailing list or IRC.
The early platform devices have not been used much outside of arch/sh
and arch/arm/mach-shmobile, and those only use it for clocksource and
serial.

Now we have a new method for both of these, at least with DT, so
my impression is that we won't need the early_platform support in
the future. One of the problems with the current interface is that
it requires statically declaring platform_device structures, which is
something that has been on Greg's list of device model antipatterns
for a long time.

> > Do you have a timeline for getting rid of the board files completely?
> 
> I don't, but it would be great if we could kill these in the next
> couple releases.

Ok, good.

	Arnd

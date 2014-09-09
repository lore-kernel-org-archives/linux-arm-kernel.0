From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 9 Sep 2014 11:15:20 +0200
Subject: [GIT PULL] at91: drivers for 3.18 #2
In-Reply-To: <26517543.McM8Q5P0vn@wuerfel>
References: <1409934969-11584-1-git-send-email-nicolas.ferre@atmel.com>
 <201409052325.11709.arnd@arndb.de>
 <20140908092642.GB20883@lukather> <26517543.McM8Q5P0vn@wuerfel>
Message-ID: <20140909091520.GJ3804@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 08, 2014 at 11:52:35AM +0200, Arnd Bergmann wrote:
> On Monday 08 September 2014 11:26:42 Maxime Ripard wrote:
> > On Fri, Sep 05, 2014 at 11:25:11PM +0200, Arnd Bergmann wrote:
> > > On Friday 05 September 2014, Nicolas Ferre wrote:
> > > > Arnd, Olof, Kevin,
> > > > 
> > > > This pull-request is focused on the work that Maxime did for migrating our timer
> > > > (PIT) to the clocksource sub-system. A big cleanup happened which allows us to
> > > > be even closer to the point when we have only the bare minimum in our formerly
> > > > crowded mach-at91 directory.
> > > > 
> > > > This pull-request goes on top of the "drivers" one already sent to you on Sept.
> > > > 01st.
> > > 
> > > Hmm, I'm not too happy to see more uses of early_platform_*, I was hoping
> > > we could kill that off in the long run. This is only used for the legacy
> > > board files, not for DT, right?
> > 
> > Yes, the DT uses the usual CLOCKSOURCE_OF_DECLARE mechanism.
> > 
> > I wasn't aware that early_platform drivers were in the killzone, but
> > I'm definitely aware that global custom exported functions are, hence
> > why I went this way.
> 
> I don't think it has been discussed much on the mailing list or IRC.
> The early platform devices have not been used much outside of arch/sh
> and arch/arm/mach-shmobile, and those only use it for clocksource and
> serial.

That's what I found, yes.

> Now we have a new method for both of these, at least with DT, so
> my impression is that we won't need the early_platform support in
> the future.

I agree with that. I only see the early platform stuff as a temporary
measure for board files, before they're removed.

> One of the problems with the current interface is that it requires
> statically declaring platform_device structures, which is something
> that has been on Greg's list of device model antipatterns for a long
> time.

I didn't find any difference with how you declare platform_devices
compared to the old-usual way in board files, or was it something on
the list too ? :)

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140909/d719a72e/attachment.sig>

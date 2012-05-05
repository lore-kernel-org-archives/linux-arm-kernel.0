From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Sat, 5 May 2012 21:08:02 +0200
Subject: [PATCH 00/02] mach-shmobile: Emma Mobile EV2 - first shot
In-Reply-To: <201205050722.45500.arnd@arndb.de>
References: <20120503144645.6390.62303.sendpatchset@w520>
 <201205042316.55593.rjw@sisk.pl> <201205050722.45500.arnd@arndb.de>
Message-ID: <201205052108.03001.rjw@sisk.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday, May 05, 2012, Arnd Bergmann wrote:
> On Friday 04 May 2012, Rafael J. Wysocki wrote:
> > I'm not sure if I understand your point correctly, so please let me clarify.
> > 
> > Do you think it's better to have a separate mach-emma directory for the
> > new hardware because technically it is a different platform and the fact
> > that it was developed by the same manufacturer as the mach-shmobile hardware
> > is less important?
> 
> Yes, that was my point. Compare this to how we have omap and davinci for TI,
> orion and pxa for Marvell, or mxs and imx for Freescale. These are all
> for the most part independent developments that happened to end up being
> owned by the same company.
> 
> We try to group code based on technical similarities, not on who makes them.
> If you are able to share code between multiple completely independent socs
> you work on, the result shouldn't be to put them into a directory you "own",
> but to generalize the common parts so they can be shared with everyone else,
> too.

This works a slightly different way for the Renesas SoCs, though.  The
mach-shmobile code is (almost) entirely specific to the SoCs and boards and
everything else is already under drivers/ and elsewhere.  That's because
much of that code is shared between the ARM and SH architectures (since there
are SH CPU core in many of those systems along with the ARM CPU cores).
So we generalize the common parts by putting them out of arch/arm rather
than by putting them into a common place in there.

Now, if you insist on us having a separate mach- directory for every platform
(SoC), we can do that I think, but then we should start with splitting up the
existing mach-shmobile into a number of SoC-specific directories rather than
adding new mach- directories for random new parts, because that goes against
our development history to date, which is important too IMHO.

Thanks,
Rafael

From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 21 May 2013 18:44:13 +0200
Subject: [PATCH 6/9] arm: mvebu: move cache and mvebu-mbus
 initialization later
In-Reply-To: <20130521163725.GW31290@titan.lakedaemon.net>
References: <1369132414-18959-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1369132414-18959-7-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130521141621.GU31290@titan.lakedaemon.net>
 <20130521173707.5a49eaec@skate>
 <20130521154313.GV31290@titan.lakedaemon.net>
 <20130521181018.401ddabf@skate>
 <20130521163725.GW31290@titan.lakedaemon.net>
Message-ID: <20130521184413.68cca154@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Cooper,

On Tue, 21 May 2013 12:37:25 -0400, Jason Cooper wrote:

> On Tue, May 21, 2013 at 06:10:18PM +0200, Thomas Petazzoni wrote:
> > On Tue, 21 May 2013 11:43:13 -0400, Jason Cooper wrote:
> > > > > I tried hacking it up to put it in mvebu/soc-internal_regs for a few
> > > > > rounds of testing in linux-next during review, however, I'd prefer you
> > > > > rebase this on top of mvebu/cleanup.
> > > > 
> > > > So you mean my next version of the "Internal registers switch" should
> > > > be based on mvebu/cleanup, right?
> > > 
> > > Yes, sorry I wasn't clear, I meant the series.  You can drop 1-3 as
> > > well for the next version, since I've pulled those.
> > 
> > Ok. 1-2 have been merged in mvebu/fixes, and 3 in mvebu/cleanup. So I
> > suppose mvebu/cleanup is based on mvebu/fixes ? Or should I base on
> > mvebu/cleanup and assume when it will lend in mainline, the mvebu/fixes
> > patches will be there (which doesn't make the thing easy for testing
> > here, because to test, I actually need all the patches in the same
> > branch). Just trying to figure the workflow :)
> 
> For your development, I would checkout v3.10-rc2, merge /fixes, then
> merge /cleanup, the put 4-9 on top.  Then, when sending, just do 4-9
> with a note about the merge dependency on /cleanup, and the boot
> dependency on /fixes.

Ok, sounds good.

> If you'd like, I can hold off on merging it until I can base the series
> on an -rc including patches 1 and 2.  As is, I might move #3 into the
> same branch as 4-9, but we'll still have the conflict I highlighted
> earlier.  And anyone resolving it will probably miss the .init_early
> removal.

Don't worry, the solution you've proposed earlier sounds fine to me.

> > Well, the current version should be ok build-wise, and works with all
> > currently available Marvell bootloaders. The bug can only be seen with
> > a bootloader version that has not yet been really released by Marvell.
> > 
> > But anyway, v2 will follow shortly. With this v1, I was mainly hoping
> > for some feedback, to see if the solution was acceptable or not.
> 
> That was a great explanation of a Schr?dinger's Register ;-)

That's a nice name for such a complicated register, indeed :)

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

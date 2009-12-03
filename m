From: daniel@caiaq.de (Daniel Mack)
Date: Thu, 3 Dec 2009 14:32:00 +0100
Subject: [PATCH] mmc: move regulator handling to core
In-Reply-To: <20091203132241.GB31533@rakim.wolfsonmicro.main>
References: <1259844390-10541-1-git-send-email-daniel@caiaq.de>
	<20091203130627.GA31254@rakim.wolfsonmicro.main>
	<20091203131423.GV14091@buzzloop.caiaq.de>
	<20091203132241.GB31533@rakim.wolfsonmicro.main>
Message-ID: <20091203133200.GX14091@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 03, 2009 at 01:22:41PM +0000, Mark Brown wrote:
> On Thu, Dec 03, 2009 at 02:14:23PM +0100, Daniel Mack wrote:

[...]

> > I would expect the power to be killed when the last user stops using it.
> > Which should result in the same effect if you only have one host, one
> > regulator, and one user.
> 
> Yes, it's always fine in that case (modulo always_on and/or regulators
> without power control). 

Well, it didn't for me and always_on, though, due to the return values I
described.

> This goes back to the thing about using
> regulator_get_exclusive(), the message given was that the MMC drivers
> really needed to be able to guarantee that the power would be removed
> when that was requested.
>
> Like I say, if there isn't a *strict* requirement but it's only
> desirable (possibly strongly desirable) then your approach is obviously
> preferable.

The mmci people would need to answer that. To me, the code just looked
like a power saving feature.

If this driver needs it, the only tweak to my patch to let that
particular call site use regulator_get_exclusive, and the core will
still do the right thing. For this case, the behaviour should be exactly
the same than it currently is, correct?

Daniel

From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 3 Dec 2009 14:58:25 +0000
Subject: [PATCH] mmc: move regulator handling to core
In-Reply-To: <20091203132241.GB31533@rakim.wolfsonmicro.main>
References: <1259844390-10541-1-git-send-email-daniel@caiaq.de>
	<20091203130627.GA31254@rakim.wolfsonmicro.main>
	<20091203131423.GV14091@buzzloop.caiaq.de>
	<20091203132241.GB31533@rakim.wolfsonmicro.main>
Message-ID: <20091203145825.GA26651@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 03, 2009 at 01:22:41PM +0000, Mark Brown wrote:
> On Thu, Dec 03, 2009 at 02:14:23PM +0100, Daniel Mack wrote:
> > I would expect the power to be killed when the last user stops using it.
> > Which should result in the same effect if you only have one host, one
> > regulator, and one user.
> 
> Yes, it's always fine in that case (modulo always_on and/or regulators
> without power control).  This goes back to the thing about using
> regulator_get_exclusive(), the message given was that the MMC drivers
> really needed to be able to guarantee that the power would be removed
> when that was requested.

If you take some cards through a series of steps and they stop responding,
it's normally because you've caused their internal state machine to
transition to "invalid" mode.

Further commands are ignored.  The only recovery is to power cycle them.

As for the regulator support in mmci, I can't say anything about it - I
don't have anything which uses it (not that I have any desire at present
to bring a MMC or SD card near Linux after my relatively new 128MB MMC
card got totally buggered with pxamci - that's not to say that Linux is
at fault, but the utter crap that seemingly most MMC/SD cards are.  Hence
why I'm not listed as maintainer of mmci.)

The regulator support in mmci is purely Linus' domain.

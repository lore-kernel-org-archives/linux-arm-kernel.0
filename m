From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 3 Dec 2009 15:09:55 +0000
Subject: [PATCH] mmc: move regulator handling to core
In-Reply-To: <20091203145825.GA26651@n2100.arm.linux.org.uk>
References: <1259844390-10541-1-git-send-email-daniel@caiaq.de>
	<20091203130627.GA31254@rakim.wolfsonmicro.main>
	<20091203131423.GV14091@buzzloop.caiaq.de>
	<20091203132241.GB31533@rakim.wolfsonmicro.main>
	<20091203145825.GA26651@n2100.arm.linux.org.uk>
Message-ID: <20091203150955.GA10297@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 03, 2009 at 02:58:25PM +0000, Russell King - ARM Linux wrote:
> On Thu, Dec 03, 2009 at 01:22:41PM +0000, Mark Brown wrote:

> > without power control).  This goes back to the thing about using
> > regulator_get_exclusive(), the message given was that the MMC drivers
> > really needed to be able to guarantee that the power would be removed
> > when that was requested.

> If you take some cards through a series of steps and they stop responding,
> it's normally because you've caused their internal state machine to
> transition to "invalid" mode.

> Further commands are ignored.  The only recovery is to power cycle them.

I assume that this is something it's desirable to be able to do in the
face of poor hardware rather than something that the Linux MMC stack is
actively using in normal operation (modulo issues with the general
quality of implementation of MMC hardware)?

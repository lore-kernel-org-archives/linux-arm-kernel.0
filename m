From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 20 Apr 2011 16:28:16 +0200
Subject: [PATCH 0/2] Common struct clk implementation, v14
In-Reply-To: <20110418105442.GB27864@linux-sh.org>
References: <1299134429.100626.661279191478.0.gpush@pororo>
	<1302754859.2767.30.camel@pororo>
	<20110414100048.GB1611@n2100.arm.linux.org.uk>
	<1302776705.28876.113.camel@pasglop>
	<20110414103200.GF1611@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1104140751220.24613@xanadu.home>
	<20110414120904.GH1611@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1104140920110.24613@xanadu.home>
	<20110414153813.GC6259@n2100.arm.linux.org.uk>
	<20110418105442.GB27864@linux-sh.org>
Message-ID: <20110420142816.GZ31131@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, Apr 18, 2011 at 07:54:42PM +0900, Paul Mundt wrote:
> If you'd prefer not to be the guinea pig for the clock bits going in to
> .40 I'm certainly happy to take them in a topic branch, convert my
> platforms on top of that and send the bits off to Linus early in the
> merge window.
To get this forward I set up a branch with the generic bits sent to the
list so far. I really think this should be fixed better now than later
to give enough time for potential users of the new API to implement it
for their platform.

The following changes since commit f0e615c3cb72b42191b558c130409335812621d8:

  Linux 2.6.39-rc4 (2011-04-18 21:26:00 -0700)

are available in the git repository at:
  git://git.pengutronix.de/git/ukl/linux-2.6.git common-struct-clk

Jeremy Kerr (2):
      Add a common struct clk
      clk: Generic support for fixed-rate clocks

Russell King - ARM Linux (1):
      Fix clkdev return value for NULL clk case

Sascha Hauer (1):
      clk: Make NULL a valid clock again

 drivers/clk/Kconfig  |    3 +
 drivers/clk/Makefile |    1 +
 drivers/clk/clk.c    |  173 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/clkdev.c |   26 +++++---
 include/linux/clk.h  |  180 +++++++++++++++++++++++++++++++++++++++++++++++---
 5 files changed, 364 insertions(+), 19 deletions(-)
 create mode 100644 drivers/clk/clk.c

I declare this to be stable, so assuming people are OK with it, you can
use that as a base to convert your platforms.

@Linus: I hope you're willing to pull this branch after .39?! (A public
"yes" might motivate one or the other maintainer to convert their
platform to it.)

There is a 2nd branch on that repository that also contains my RFC patch
just sent to this list in case you want to test it.

The following changes since commit 0ddb7f510fd51213801bf33194629fabf0818f39:

  clk: Make NULL a valid clock again (2011-04-20 16:02:29 +0200)

are available in the git repository at:
  git://git.pengutronix.de/git/ukl/linux-2.6.git common-struct-clk-wip

Uwe Kleine-K?nig (1):
      [RFC] clk: add support for automatic parent handling

 drivers/clk/clk.c   |   43 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/clk.h |    8 ++++++++
 2 files changed, 51 insertions(+), 0 deletions(-)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 29 Sep 2009 15:24:41 +0100
Subject: [PATCH] i2c: imx: check busy bit when START/STOP
In-Reply-To: <4e090d470909290654r6fb36cb4h505662c7cb84b1f8@mail.gmail.com>
References: <4e090d470909290441i7016c4f4g9a929d78838f9b7@mail.gmail.com>
	<20090929132505.GM27039@pengutronix.de>
	<4e090d470909290654r6fb36cb4h505662c7cb84b1f8@mail.gmail.com>
Message-ID: <20090929142440.GF32420@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 29, 2009 at 09:54:05PM +0800, Richard Zhao wrote:
> On Tue, Sep 29, 2009 at 9:25 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:

> > I think it's generally a good idea to start/stop the clocks when needed
> > as you do here. It should be an extra patch though.

> You think I should split the patch to three: IBB, reg_dump, clk dis/en ?
> The idea is good, more easy to revert. but sometimes, I think it make
> small things too complex.

Keeping small things simple is half the reason for doing this - it's not
just bisection, it's also the fact that it's much easier to read and
understand a small patch that does one thing than it is to do the same
with a large patch which makes several unrelated changes.  When several
changes are lumped in together it's harder to see the complete version
of any one change in isolation and more effort is required to work out
which goals are being accomplished with any given chunk of the patch.

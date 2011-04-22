From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 22 Apr 2011 21:35:26 +0100
Subject: Common clock and dvfs
In-Reply-To: <BANLkTin9mbGKAMB4Bgd=5th+6FgS9gMCtA@mail.gmail.com>
References: <BANLkTimVXbp1pFsGPcs-RPY+PTOF6ZRyoQ@mail.gmail.com>
	<20110422194027.GB4768@sirena.org.uk>
	<BANLkTin9mbGKAMB4Bgd=5th+6FgS9gMCtA@mail.gmail.com>
Message-ID: <20110422203526.GC4768@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 22, 2011 at 12:48:37PM -0700, Colin Cross wrote:
> On Fri, Apr 22, 2011 at 12:40 PM, Mark Brown

> > This sounds like it assumes a 1:1 mapping between clocks and supplies
> > which is going to break at some point. ?It should be handlable but will
> > add complexity.

> Almost every platform requires a many-to-one mapping between clocks
> and supplies (many clocks fed off one supply), and I bet at least one
> platform has one clock that requires changing two supplies, so a

In most of the platforms I've looked at the supported configurations are
specified en masse as operating points so it definitely ends up being
the case, you get a set of frequencies and a set of voltages specified
as a block.

> many-to-many mapping is probably required.  It's not hard, I
> implemented it for Tegra before moving to a many-to-one - each
> relationship between a clock and a supply can be treated
> independently, so the pointers in the clock and dvfs structs can just
> be converted to lists of an intermediate struct.

Right, but like I say it does add complexity.  I'm not sure it's
noticably more than what you get from having to link some of the clock
rates, though.

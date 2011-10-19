From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 19 Oct 2011 15:47:34 +0100
Subject: [PATCH v2 3/5] regulator: helper routine to extract
	regulator_init_data
In-Reply-To: <20111019053354.GB31162@S2100-06.ap.freescale.net>
References: <1318263578-7407-1-git-send-email-rnayak@ti.com>
	<1318263578-7407-4-git-send-email-rnayak@ti.com>
	<20111016145536.GA29885@S2100-06.ap.freescale.net>
	<4E9BAC4D.3010402@ti.com>
	<20111018115836.GC30703@S2100-06.ap.freescale.net>
	<20111018160046.GD28501@opensource.wolfsonmicro.com>
	<20111019053354.GB31162@S2100-06.ap.freescale.net>
Message-ID: <20111019144734.GI18713@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 19, 2011 at 01:33:55PM +0800, Shawn Guo wrote:
> On Tue, Oct 18, 2011 at 05:00:46PM +0100, Mark Brown wrote:

> > It's not just Linux-specific stuff, some of this is even specific to
> > what current Linux drivers can do - updating the kernel could mean a
> > different set of constraints.

> Well, from what I see, the 'struct regulation_constraints' is defined
> in machine.h and meant to be the regulator machine/board interface.

...which will depend on the system integrator's understanding of what
their system is capable of right now.

> With the example I'm looking at, mc13892, the regulation_constraints
> configuration is fully passed from machine/board file.  If there is
> something specific to what drivers can do, it probably should be encoded
> in regulator driver rather than staying in regulation_constraints.

I don't think you're quite understanding the issue - it's an integration
problem with three different variables.  It's a combination of what the
chips can do, what the drivers can do and if the board design affects
any of this stuff.  Only the board can come to a final decision.

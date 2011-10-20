From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 20 Oct 2011 17:40:06 +0100
Subject: [PATCH v2 3/5] regulator: helper routine to extract
	regulator_init_data
In-Reply-To: <20111020162743.GB31337@atomide.com>
References: <4E9BAC4D.3010402@ti.com>
	<20111018115836.GC30703@S2100-06.ap.freescale.net>
	<20111018160046.GD28501@opensource.wolfsonmicro.com>
	<20111019053354.GB31162@S2100-06.ap.freescale.net>
	<20111019144734.GI18713@sirena.org.uk>
	<20111019150448.GB32007@S2100-06.ap.freescale.net>
	<20111019151031.GA4275@opensource.wolfsonmicro.com>
	<4E9F9892.9070007@ti.com> <20111020094140.GK18713@sirena.org.uk>
	<20111020162743.GB31337@atomide.com>
Message-ID: <20111020164006.GA10155@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 20, 2011 at 09:27:43AM -0700, Tony Lindgren wrote:
> * Mark Brown <broonie@opensource.wolfsonmicro.com> [111020 02:07]:

> > We can always start off just completely omitting the data and then see
> > how we go from there.  If we only cover 50% of users that's still 50%
> > more than are currently covered with device tree right now and it means
> > we can then spin round and look at the bits that are hard again without
> > review fatigue on the bits that are easy.

> We still need to pass the board configuration somehow, otherwise we can
> never remove all the platform data glue layers. And if we can't do that,
> we'll forever have all the nasty merge conflicts when adding new drivers.
> And there's an unnecessary dependency between adding drivers and the
> core SoC code.

The current patches cover the overwhelming majority of the existing
board configuration - the stuff that's Linux specific is also relatively
rarely used in actual systems.  For example all the board I work with
regularly would be perfectly happy with the generic stuff - the Linux
specific stuff is relatively rarely used.

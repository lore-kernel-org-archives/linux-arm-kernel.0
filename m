From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 14 Dec 2009 11:04:57 +0000
Subject: [PATCH 3/4] regulator: add voltage selection capability to
	mc13783 regulators.
In-Reply-To: <1260787298.2022.55.camel@climbing-alby>
References: <1260635829.2054.16.camel@climbing-alby>
	<1260636523.2054.28.camel@climbing-alby>
	<1260636819.2054.33.camel@climbing-alby>
	<1260636976.2054.36.camel@climbing-alby>
	<20091213200142.GC14024@pengutronix.de>
	<1260787298.2022.55.camel@climbing-alby>
Message-ID: <20091214110457.GA21066@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 14, 2009 at 11:41:38AM +0100, Alberto Panizzo wrote:

> Maybe the PLL must be initialised and controlled via another driver, 
> in the audio codec?

That would be the normal place to control a PLL used to clock the audio
subsystem, yes.  If it's more generally used then it probably ought to
go in the core driver - something along the lines of the clock API would
be useful for arbitration (the clock API itself can't really be used
since it only really works with on-SoC clocks).

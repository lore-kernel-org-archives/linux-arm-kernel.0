From: tony@atomide.com (Tony Lindgren)
Date: Thu, 20 Oct 2011 13:10:55 -0700
Subject: [PATCH v2 3/5] regulator: helper routine to extract
	regulator_init_data
In-Reply-To: <20111020195734.GB17384@opensource.wolfsonmicro.com>
References: <20111019144734.GI18713@sirena.org.uk>
	<20111019150448.GB32007@S2100-06.ap.freescale.net>
	<20111019151031.GA4275@opensource.wolfsonmicro.com>
	<4E9F9892.9070007@ti.com> <20111020094140.GK18713@sirena.org.uk>
	<20111020162743.GB31337@atomide.com>
	<20111020164006.GA10155@sirena.org.uk>
	<20111020170534.GC31337@atomide.com>
	<20111020172218.GE31337@atomide.com>
	<20111020195734.GB17384@opensource.wolfsonmicro.com>
Message-ID: <20111020201054.GN3842@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Mark Brown <broonie@opensource.wolfsonmicro.com> [111020 12:23]:
> On Thu, Oct 20, 2011 at 10:22:19AM -0700, Tony Lindgren wrote:
> 
> > Hmm, actually, can't we just pass the board specific configuration in
> > the board specific .dts file and then it gets merged in with the
> > arch independent DT node?
> 
> I don't understand what an "arch independent DT node" would be?

Well that's the standard non-Linux specific parts. Basically what's
in the $Subject patch minus what you commented on earlier:

> +- regulator-change-voltage: boolean, Output voltage can be changed by software
> +- regulator-change-current: boolean, Output current can be chnaged by software
> +- regulator-change-mode: boolean, Operating mode can be changed by software
> +- regulator-change-status: boolean, Enable/Disable control for regulator exists
> +- regulator-change-drms: boolean, Dynamic regulator mode switching is enabled
> +- regulator-mode-fast: boolean, allow/set fast mode for the regulator
> +- regulator-mode-normal: boolean, allow/set normal mode for the regulator
> +- regulator-mode-idle: boolean, allow/set idle mode for the regulator
> +- regulator-mode-standby: boolean, allow/set standby mode for the regulator
> +- regulator-input-uV: Input voltage for regulator when supplied by another regulator
> +- regulator-always-on: boolean, regulator should never be disabled

We still need to figure out how to get the above board specific
data to the device driver probe in a way where we can avoid having
platform glue code. Any thoughts on that?

Tony

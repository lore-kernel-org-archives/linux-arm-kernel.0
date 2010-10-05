From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 4 Oct 2010 22:59:37 -0700
Subject: [alsa-devel] [PATCH 10/10] ASoC: SAMSUNG: Add Machine driver
	for S/PDIF PCM audio
In-Reply-To: <AANLkTi=x_fi5HTBBmMUv8YTxSdbgcnJ=ZbacJQj6rcgf@mail.gmail.com>
References: <1286191550-22197-1-git-send-email-sw.youn@samsung.com>
	<1286194583-19937-1-git-send-email-sw.youn@samsung.com>
	<20101004224159.GA4972@opensource.wolfsonmicro.com>
	<AANLkTi=FHGw+qzL507K546vr8zEZgXBP3Mk=O__Rpd4H@mail.gmail.com>
	<AANLkTincwL_nQAmu7Dcmht0FV43BiN7OoecE_60QJhS2@mail.gmail.com>
	<20101005044304.GA26509@opensource.wolfsonmicro.com>
	<AANLkTi=x_fi5HTBBmMUv8YTxSdbgcnJ=ZbacJQj6rcgf@mail.gmail.com>
Message-ID: <20101005055937.GA19989@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 05, 2010 at 02:39:00PM +0900, Jassi Brar wrote:

> Yes we can have a kconfig entry for 'Controllable EPLL' but that seems
> orthogonal to ASoC because, for SMDKs, we choose to produce
> accurate signals hence need to manipulate EPLL. The only point is
> where to do it.

Well, there's two approaches the driver can take: one is to change the
EPLL to deliver the clock rates which allow maximum flexibility, the
other is to constrain the clock rates offered to applications based on
the frequencies that can be generated from the current EPLL setup.

> (our priority is accuracy of each IP's functioning rather than having
> all parts of
> SMDK playing nice with each other on such h/w design issues)

That'd be the problem, kind of - it does mean people can get burned when
they pick up the BSP code and use it as a reference for their systems.

> I hope you noticed that this clock hierarchy is a _very_ board specific thing.
> We can easily place SoCs' shared stuff in arch/arm/plat-samsung (or similar)
> Any suggestions, where do we place code shared by SMDK-boards ?

plat-samsung would probably be fine for that also - create a file called
common-smdk or something.  Some other things have gone for a plat-smdk
style approach too, though I'm not sure how tasteful I find that
personally.

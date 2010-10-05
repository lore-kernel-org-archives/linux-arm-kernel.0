From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 5 Oct 2010 09:54:28 -0700
Subject: [alsa-devel] [PATCH 10/10] ASoC: SAMSUNG: Add Machine driver
	for S/PDIF PCM audio
In-Reply-To: <AANLkTimi1t5S2XWdUFzaPttD4Hywm0SLt5CvR1YnVOjj@mail.gmail.com>
References: <1286191550-22197-1-git-send-email-sw.youn@samsung.com>
	<1286194583-19937-1-git-send-email-sw.youn@samsung.com>
	<20101004224159.GA4972@opensource.wolfsonmicro.com>
	<AANLkTi=FHGw+qzL507K546vr8zEZgXBP3Mk=O__Rpd4H@mail.gmail.com>
	<AANLkTincwL_nQAmu7Dcmht0FV43BiN7OoecE_60QJhS2@mail.gmail.com>
	<20101005044304.GA26509@opensource.wolfsonmicro.com>
	<AANLkTi=x_fi5HTBBmMUv8YTxSdbgcnJ=ZbacJQj6rcgf@mail.gmail.com>
	<20101005055937.GA19989@opensource.wolfsonmicro.com>
	<AANLkTimi1t5S2XWdUFzaPttD4Hywm0SLt5CvR1YnVOjj@mail.gmail.com>
Message-ID: <20101005165427.GB20555@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 05, 2010 at 04:09:47PM +0900, Jassi Brar wrote:
> On Tue, Oct 5, 2010 at 2:59 PM, Mark Brown

> > Well, there's two approaches the driver can take: one is to change the
> > EPLL to deliver the clock rates which allow maximum flexibility, the
> > other is to constrain the clock rates offered to applications based on
> > the frequencies that can be generated from the current EPLL setup.

> For SMDKs(our reference platform) I would like to change EPLL in order
> to be able to verify accuracy and provide all capabilities of the controllers.

That's why I'm saying provide an option to turn this behaviour on - I
agree that it's useful to be able to show the feature, I just think it's
going to catch users out if they're not warned that it's happening
somehow.

> >> (our priority is accuracy of each IP's functioning rather than having
> >> all parts of
> >> SMDK playing nice with each other on such h/w design issues)

> > That'd be the problem, kind of - it does mean people can get burned when
> > they pick up the BSP code and use it as a reference for their systems.

> I expect people to replace/modify/inspect board specific code before they
> run the BSP on their systems. IMO reference platforms are not good for
> integrated-testing.

To be fair the users doing this the individual drivers do look OK by
themselves - there's only a problem when it comes to system integration
and that's not going to be obvious unless someone has reviewed the
drivers while understanding the clock tree for the chip as a whole.

From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 7 Jun 2010 16:35:34 +0100
Subject: [PATCH v2] pxa/z2: Add regulator support
In-Reply-To: <201006071656.33063.marek.vasut@gmail.com>
References: <1275883143-3512-1-git-send-email-marek.vasut@gmail.com>
	<20100607113910.GC5993@sirena.org.uk>
	<201006071656.33063.marek.vasut@gmail.com>
Message-ID: <20100607153534.GH13287@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 07, 2010 at 04:56:33PM +0200, Marek Vasut wrote:
> Dne Po 7. ?ervna 2010 13:39:10 Mark Brown napsal(a):

> > Are you *sure* that the voltages for these regulators can be varied this
> > much (especailly given that there are no consumers set up)?

> These are not connected so I believe it doesn't matter. Though I'm still 
> slightly unfamiliar with the regulator API. Here I should have CCed you, sorry.
> 
> Is this the correct way or is there some other way to just shut these off ?

Call regulator_has_full_constraints() in your machine driver, they'll be
shut off at the end of boot when nothing is using them.

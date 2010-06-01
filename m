From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 1 Jun 2010 13:53:21 +0100
Subject: [PATCH v2] ARM: S5PV210: Add Power Management Support
In-Reply-To: <20100601041633.GB30276@trinity.fluff.org>
References: <1275356164-7896-1-git-send-email-kgene.kim@samsung.com>
	<20100601020329.GT4720@trinity.fluff.org>
	<AANLkTinNCTUtXDeRTOBi05Yv7FoatY2ruWmnNtTSmg36@mail.gmail.com>
	<20100601041633.GB30276@trinity.fluff.org>
Message-ID: <20100601125320.GA10031@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 01, 2010 at 05:16:33AM +0100, Ben Dooks wrote:
> On Tue, Jun 01, 2010 at 12:23:39PM +0900, Kyungmin Park wrote:

> > It's common function. Please add it to platform init instead of each board init.

> I know Mark Brown would rather this be the case too, but the original intent
> was that each board would declare itself to be capable of PM by calling this
> function to ensure that any boards which had not been validated or where
> simply incapable of suspend/resume did not end up with this enabled.

This does result in rather confusing behaviour, in that the attempts to
suspend end up getting silently ignored which isn't what you expect.
Other ARM platforms deal with this by erroring out of the suspend if
they can tell that it's not going to work and otherwise just trusting
the system integrator to know what they're doing when they turn on
suspend in Kconfig.

It would be more friendly to at least put in a default implementation
which prints an error telling the user what they need to do to actually
get suspend working.

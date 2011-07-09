From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sat, 9 Jul 2011 11:23:37 +0100
Subject: [PATCH 1/2] drivers: create a pinmux subsystem v3
In-Reply-To: <BANLkTi=r=N5OwfsVLRuBsNRSpv91pTgeKA@mail.gmail.com>
References: <1307984291-9774-1-git-send-email-linus.walleij@stericsson.com>
	<BANLkTi=r=N5OwfsVLRuBsNRSpv91pTgeKA@mail.gmail.com>
Message-ID: <20110709102337.GD9247@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 13, 2011 at 01:57:36PM -0600, Grant Likely wrote:
> On Mon, Jun 13, 2011 at 10:58 AM, Linus Walleij

> > +This get/enable/disable/put sequence can just as well be handled by bus drivers
> > +if you don't want each and every driver to handle it and you know the
> > +arrangement on your bus.

> I would *strongly* recommend against individual device drivers
> accessing the pinmux api.  This is system level configuration code,
> and should be handled at the system level.

There can also be advantages to putting the pin into the designed mode
without the driver being loaded from the electrical point of view.  For
example, selecting appropriate pull values for pads can cut down on
power consumption.

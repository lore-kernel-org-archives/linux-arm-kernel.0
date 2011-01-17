From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 17 Jan 2011 15:33:03 +0000
Subject: [PATCH] ux500: add a few AB8500 regulator consumers
In-Reply-To: <AANLkTi=gsmiGFF31Si71LQBAZqpZZcxMDOK6e3xAyZV7@mail.gmail.com>
References: <1295269491-12107-1-git-send-email-linus.walleij@stericsson.com>
	<20110117132745.GA21113@opensource.wolfsonmicro.com>
	<AANLkTi=gsmiGFF31Si71LQBAZqpZZcxMDOK6e3xAyZV7@mail.gmail.com>
Message-ID: <20110117153303.GK21113@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 17, 2011 at 03:11:04PM +0100, Linus Walleij wrote:
> 2011/1/17 Mark Brown <broonie@opensource.wolfsonmicro.com>:

> >> + ? ? {
> >> + ? ? ? ? ? ? .supply = "ab8500-gpadc",
> >> + ? ? },

> > I suspect there's a device for the ab8500?

> This is not the AB8500 actually, but a subdevice (MFD cell) for it
> that creates its own platform device and is separately powered.
> (Though using in-chip wiring I presume.)

It may be more sane to just have the subdevices use the core struct
device for requests for legibility.

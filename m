From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 16 Jul 2012 13:40:17 +0000
Subject: [PATCH v2 1/2] pinctrl: pinctrl-imx: add support for set bits for
 general purpose registers
In-Reply-To: <20120716081703.GH21635@b20223-02.ap.freescale.net>
References: <1342084080-3145-1-git-send-email-b29396@freescale.com>
 <CACRpkdbHtgKLA3JJxc4VY35zSpJFvk15u62Z3aBCqERoeQ10CA@mail.gmail.com>
 <20120716081703.GH21635@b20223-02.ap.freescale.net>
Message-ID: <201207161340.18528.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 16 July 2012, Richard Zhao wrote:
> > If you really wants a "funnel driver" doing all these diverse things,
> > I'd put it in drivers/mfd.
>
> It's like driver drivers/mfd/anatop-mfd.c. They both store misc bits.
> We may need a generic driver to simply provide register accessor.

We already have the "regmap" framework that deals with sets of registers
on spi, i2c or memory mapped buses. One thing I've thought about
before is to create some kind of very simple "system controller"
framework based on regmap that lets you register a single global
"struct regmap" pointer from an SoC specific driver, and have drivers
call a function into that framework to get a reference to that
regmap.

	Arnd

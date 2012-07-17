From: b29396@freescale.com (Dong Aisheng)
Date: Tue, 17 Jul 2012 11:04:12 +0800
Subject: [PATCH v2 1/2] pinctrl: pinctrl-imx: add support for set bits
 for general purpose registers
In-Reply-To: <201207161340.18528.arnd@arndb.de>
References: <1342084080-3145-1-git-send-email-b29396@freescale.com>
 <CACRpkdbHtgKLA3JJxc4VY35zSpJFvk15u62Z3aBCqERoeQ10CA@mail.gmail.com>
 <20120716081703.GH21635@b20223-02.ap.freescale.net>
 <201207161340.18528.arnd@arndb.de>
Message-ID: <20120717030411.GG19699@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 16, 2012 at 09:40:17PM +0800, Arnd Bergmann wrote:
> On Monday 16 July 2012, Richard Zhao wrote:
> > > If you really wants a "funnel driver" doing all these diverse things,
> > > I'd put it in drivers/mfd.
> >
> > It's like driver drivers/mfd/anatop-mfd.c. They both store misc bits.
> > We may need a generic driver to simply provide register accessor.
> 
> We already have the "regmap" framework that deals with sets of registers
> on spi, i2c or memory mapped buses. One thing I've thought about
Thanks for the hints.
Will look into it.

> before is to create some kind of very simple "system controller"
> framework based on regmap that lets you register a single global
> "struct regmap" pointer from an SoC specific driver, and have drivers
> call a function into that framework to get a reference to that
> regmap.
> 
That would be a good idea to make people easy use.

Regards
Dong Aisheng

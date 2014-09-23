From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 23 Sep 2014 16:55:10 +0200
Subject: [PATCH v2 4/4] ARM: dts: mt8135: Add pinctrl node for mt8135.
In-Reply-To: <7840459.vtELiqVIOL@wuerfel>
References: <1411443545-24951-1-git-send-email-srv_hongzhou.yang@mediatek.com>
 <2770365.r419rjIAOU@wuerfel> <1411480694.21299.18.camel@mtksdaap41>
 <7840459.vtELiqVIOL@wuerfel>
Message-ID: <20140923145510.GX4992@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 23, 2014 at 04:10:09PM +0200, Arnd Bergmann wrote:
> On Tuesday 23 September 2014 21:58:14 Joe. C wrote:
> > Thanks for review. 
> > The intend for these macros is helpin pinctrl user to write DT node.
> > With these macro, we could write like this for i2c0:
> > 
> > mediatek,pinfunc = <MT8135_PIN_100_SDA0__FUNC_SDA0 
> >                         MT8135_PIN_101_SCL0__FUNC_SCL0>;
> > 
> > We feel this is less error prone and easier to write than this:
> > 
> > mediatek,pinfunc = <MT_PIN_FUNC(100, 1) MT_PIN_FUNC(101, 1)>
> 
> But you don't actually use the same macros in the driver, so in effect
> you just move the definitions from the file they are needed in to another
> file as a macro.
> 
> It is no less error prone to define those macros in mt8135-pinfunc.h
> than in the pinctrl node, just less readable.

IMO these defines make writing and reviewing dts files much easier. Once
the macros are used widely and thus are likely correct you can be sure
that every board has sane and non conflicting pin setups. The pin names
can often be found in the schematics of a board, so you can verify the
pinmux settings without looking in the SoC datasheet.

If all you have in the dts files is MT_PIN_FUNC(pinx, funcy) then it
can be quite hard to verify pins. First you have to get an idea how
the pin numbers match the pins in the datasheet. In the bindings the
pins are numbered, in the datasheet they usually only have names.
Afterwards you have to find out which functions this pin has and how
these match to the function number in the binding. Repeat this for
dozens of pins.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

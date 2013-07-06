From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 06 Jul 2013 11:18 +0200
Subject: MTD EEPROM support and driver integration
In-Reply-To: <20130706082804.GZ2959@lukather>
References: <20130705201118.GM2959@lukather>
 <201307060033.13259.arnd@arndb.de> <20130706082804.GZ2959@lukather>
Message-ID: <5811519.oHVuMujf0I@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 06 July 2013 10:28:04 Maxime Ripard wrote:
> > a) like interrupts, regs, dmas, clocks, pinctrl, reset, pwm: fixed property names
> > 
> >       regmap = <&at25 0xstart 0xlen>;
> >       regmap-names = "mac-address";
> > 
> > b) like gpio, regulator: variable property names
> > 
> >       mac-storage = <&at25 0xstart 0xlen>;
> > 
> > It's unfortunate that we already have examples of both. They are largely
> > equivalent, but the tendency is towards the first.
> 
> I don't have a strong feeling for one against another, so whatever works
> best. Both solutions will be a huge improvement anyway 
> 
> Just out of curiosity, is there any advantages besides having a fixed
> property name to the first solution?

I think it's mostly for consistency: trying to get most subsystems to
do it the same way to make it easier for people to write dts files.

A lesser point is that it simplifies the driver code if you don't
have to pass a name.


	Arnd

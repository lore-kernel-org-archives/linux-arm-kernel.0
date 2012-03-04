From: jason@lakedaemon.net (Jason)
Date: Sun, 4 Mar 2012 17:27:10 -0500
Subject: [PATCH 3/4] ARM: kirkwood: convert rtc-mv to fdt.
In-Reply-To: <201203041648.17428.arnd@arndb.de>
References: <cover.1330625877.git.jason@lakedaemon.net>
 <2c985a303f3b9b0cfcead25634b7e1db68d34ee3.1330625878.git.jason@lakedaemon.net>
 <201203041559.23810.michael@walle.cc>
 <201203041648.17428.arnd@arndb.de>
Message-ID: <20120304222710.GT11986@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 04, 2012 at 04:48:17PM +0000, Arnd Bergmann wrote:
> On Sunday 04 March 2012, Michael Walle wrote:
> > in my older patch series i flagged all converted devices with two 
> > compatibility names. Eg:
> > 
> >        { .compatible = "marvell,orion5x-rtc", },
> >        { .compatible = "marvell,kirkwood-rtc", },
> > 
> > IMHO marvell,rtc is i little too general, i guess marvell won't have only one 
> > rtc ;)
> > 
> > Other opinions?
> 
> Being specific is certainly good, and it may also be a good idea to
> list the first one it's compatible with in the device tree source.
> 
> So the device tree for a 88F6281 soc could list
> 
> 	compatible = "marvell,88f6281-rtc", "marvell,kirkwood-rtc", "marvell,orion-rtc";

I'll go ahead and make this style of change throughout.  I assume
"marvell,88f6281-rtc" would only be for SoC internal devices?  eg, the spi
driver wouldn't follow that convention.  I'll see if I can dig up a part
number on it.

> This would give the device driver the option which one to bind to. Anything that
> has an rtc compatible with the one in orion should list that one, so that the driver
> only has to list that one if they are truely identical, but if the driver has to
> get modified later to know the difference between orion and kirkwood rtcs, it can
> check the more specific value.
> 
> 	Arnd

thx,

Jason.

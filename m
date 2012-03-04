From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 4 Mar 2012 16:48:17 +0000
Subject: [PATCH 3/4] ARM: kirkwood: convert rtc-mv to fdt.
In-Reply-To: <201203041559.23810.michael@walle.cc>
References: <cover.1330625877.git.jason@lakedaemon.net>
 <2c985a303f3b9b0cfcead25634b7e1db68d34ee3.1330625878.git.jason@lakedaemon.net>
 <201203041559.23810.michael@walle.cc>
Message-ID: <201203041648.17428.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 04 March 2012, Michael Walle wrote:
> in my older patch series i flagged all converted devices with two 
> compatibility names. Eg:
> 
>        { .compatible = "marvell,orion5x-rtc", },
>        { .compatible = "marvell,kirkwood-rtc", },
> 
> IMHO marvell,rtc is i little too general, i guess marvell won't have only one 
> rtc ;)
> 
> Other opinions?

Being specific is certainly good, and it may also be a good idea to
list the first one it's compatible with in the device tree source.

So the device tree for a 88F6281 soc could list

	compatible = "marvell,88f6281-rtc", "marvell,kirkwood-rtc", "marvell,orion-rtc";

This would give the device driver the option which one to bind to. Anything that
has an rtc compatible with the one in orion should list that one, so that the driver
only has to list that one if they are truely identical, but if the driver has to
get modified later to know the difference between orion and kirkwood rtcs, it can
check the more specific value.

	Arnd

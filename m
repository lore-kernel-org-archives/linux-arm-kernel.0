From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 6 Nov 2011 17:05:38 +0100
Subject: orion/kirkwood and device tree
In-Reply-To: <201110312350.28475.michael@walle.cc>
References: <20111031105740.GC29402@lunn.ch>
 <20111031152100.GR32165@titan.lakedaemon.net>
 <20111031164042.GD29402@lunn.ch>
 <201110312350.28475.michael@walle.cc>
Message-ID: <20111106160538.GD19491@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 31, 2011 at 11:50:28PM +0100, Michael Walle wrote:
> i've already ported some marvell devices to DT. spi-orion, orion-wdt, rtc-mv 
> and mv_cesa. Atm i'm struggling with how to pass kirkwood_mbus_dram_info to 
> the device drivers (the old method is to pass it through platform_data)

Hi Michael

Soon to follow is my patch to cleanup the address mapping of orion
based platforms. I think this is one step towards solving your
kirkwood_mbus_dram_info problem. I think the next steps are:

Rename all the {kirkwood|dove|orion5x|mv78xx0}_mbus_dram_info to
orion_mbus_dram_info and move this variable into
arch/arm/plat-orion/addr-map.c.

Move all the address setup code which is currently in various drives
into arch/arm/plat-orion/addr-map.c. Remove orion_mbus_dram_info from
all the platform_data structures.

Try to consolidate the different device address setup code. A lot
looks very similar, so it should be possible.

      Andrew

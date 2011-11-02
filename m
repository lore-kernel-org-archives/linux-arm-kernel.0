From: michael@walle.cc (Michael Walle)
Date: Wed, 2 Nov 2011 23:03:04 +0100
Subject: orion/kirkwood and device tree
In-Reply-To: <20111102165057.GU32165@titan.lakedaemon.net>
References: <20111031105740.GC29402@lunn.ch>
	<201110312350.28475.michael@walle.cc>
	<20111102165057.GU32165@titan.lakedaemon.net>
Message-ID: <201111022303.04957.michael@walle.cc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch 02 November 2011, 17:50:57 schrieb Jason:
> Michael,
> 
> On Mon, Oct 31, 2011 at 11:50:28PM +0100, Michael Walle wrote:
> > i've already ported some marvell devices to DT. spi-orion, orion-wdt,
> > rtc-mv and mv_cesa. Atm i'm struggling with how to pass
> > kirkwood_mbus_dram_info to the device drivers (the old method is to pass
> > it through platform_data)
> 
> Do you have a public git tree I could pull from, by chance?  I don't
> care about the state, I'd like to learn by example and start pitching
> in.

yeah i pushed it to github:
https://github.com/mwalle/linux/tree/kirkwood-devtree

Am Dienstag 01 November 2011, 07:25:23 schrieben Andrew:
> I have some changes in this area in my tree
Andrew, is your repository public?

> We could maybe put this table into DT?
I don't know if these informations belong to the DT or to generic kirkwood 
arch support (eg. mach-kirkwood/board-dt.c).

In both cases there needs to be some functions to retrieve these properties 
(instead of passing a pointer to some structure around). But i don't know if 
this fits the linux device drivers concept, eg. to be independent from any 
architecture.

So if any kernel hacker is reading this, i'm happy for every hint :) The 
problem is that most kirkwood/orion SoC devices needs a memory map to set up 
its internal memory windows for DMA access. Actually it only uses one window, 
which addresses the main memory. The arch-{kirkwood,orion} code stores the 
needed informations within a static *_mbus_dram_info variable, which is then 
passed as a pointer within platform_data to the device driver.

Is there a best practice for doing such things with device tree aware drivers?

-- 
Michael

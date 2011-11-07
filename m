From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 7 Nov 2011 07:27:04 +0100
Subject: orion/kirkwood and device tree
In-Reply-To: <201111062340.59042.michael@walle.cc>
References: <20111031105740.GC29402@lunn.ch>
 <201110312350.28475.michael@walle.cc>
 <20111106160538.GD19491@lunn.ch>
 <201111062340.59042.michael@walle.cc>
Message-ID: <20111107062704.GF19491@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 06, 2011 at 11:40:58PM +0100, Michael Walle wrote:
> Hi Andrew,
> 
> thanks for the patch,
> 
> Am Sonntag 06 November 2011, 17:05:38 schrieb Andrew Lunn:
> > Soon to follow is my patch to cleanup the address mapping of orion
> > based platforms. I think this is one step towards solving your
> > kirkwood_mbus_dram_info problem. I think the next steps are:
> > 
> > Rename all the {kirkwood|dove|orion5x|mv78xx0}_mbus_dram_info to
> > orion_mbus_dram_info and move this variable into
> > arch/arm/plat-orion/addr-map.c.
> > 
> > Move all the address setup code which is currently in various drives
> > into arch/arm/plat-orion/addr-map.c. Remove orion_mbus_dram_info from
> > all the platform_data structures.
> mh and then use orion_mbus_dram_info directly within the device drivers?

No. Since all the address setup is now inside
arch/arm/plat-orion/addr-map.c, the drivers themselves have no need of
orion_mbus_dram_info.

I'm about 75% through modifying the code. I hope i can find a couple
of hours to get it finished and tested.

   Andrew

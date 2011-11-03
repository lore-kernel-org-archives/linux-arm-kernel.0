From: linux_arm@lakedaemon.net (Jason)
Date: Thu, 3 Nov 2011 14:15:25 -0400
Subject: memory map in fdt was: Re: orion/kirkwood and device tree
In-Reply-To: <201111022303.04957.michael@walle.cc>
References: <20111031105740.GC29402@lunn.ch>
	<201110312350.28475.michael@walle.cc>
	<20111102165057.GU32165@titan.lakedaemon.net>
	<201111022303.04957.michael@walle.cc>
Message-ID: <20111103181525.GV32165@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Michael,

I've added the devicetree ml to the CC:.  Hopefully someone there can
provide some insight...

On Wed, Nov 02, 2011 at 11:03:04PM +0100, Michael Walle wrote:
> Am Dienstag 01 November 2011, 07:25:23 schrieben Andrew:
> > 
> > We could maybe put this table into DT?
> 
> I don't know if these informations belong to the DT or to generic kirkwood 
> arch support (eg. mach-kirkwood/board-dt.c).
> 
> In both cases there needs to be some functions to retrieve these properties 
> (instead of passing a pointer to some structure around). But i don't know if 
> this fits the linux device drivers concept, eg. to be independent from any 
> architecture.
> 
> So if any kernel hacker is reading this, i'm happy for every hint :) The 
> problem is that most kirkwood/orion SoC devices needs a memory map to set up 
> its internal memory windows for DMA access. Actually it only uses one window, 
> which addresses the main memory. The arch-{kirkwood,orion} code stores the 
> needed informations within a static *_mbus_dram_info variable, which is then 
> passed as a pointer within platform_data to the device driver.
> 
> Is there a best practice for doing such things with device tree aware drivers?

thx,

Jason.

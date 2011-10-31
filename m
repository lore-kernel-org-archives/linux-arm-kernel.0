From: michael@walle.cc (Michael Walle)
Date: Mon, 31 Oct 2011 23:50:28 +0100
Subject: orion/kirkwood and device tree
In-Reply-To: <20111031164042.GD29402@lunn.ch>
References: <20111031105740.GC29402@lunn.ch>
	<20111031152100.GR32165@titan.lakedaemon.net>
	<20111031164042.GD29402@lunn.ch>
Message-ID: <201110312350.28475.michael@walle.cc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason and all,

Sorry for being quiet such a long time, much work to do here..

Am Montag 31 Oktober 2011, 17:40:42 schrieb Andrew Lunn:
> > I wish.  :-)  dreamplug support just made it into u-boot.  So, now I
> > just have to babysit it until 2011.12 / 2012.01 release.  I should have
> > some more cycles to dedicate to Linux/dreamplug in the coming months.
> 
> Is uboot support necessary? I cannot use jtag on my device, so i'm
> reluctant to upgrade uboot. I hope it is possible to append the dt to
> kernel image, at least for development work.
iirc, i've seen some patches around to add support for appended device trees. 
dunno if they made it upstream, though.

> > My biggest stumbling block is still learning devicetree.  Simon Glass
> > has added support for parsing and using fdt's in u-boot.  I successfully
> > adapted mvrtc driver to use it.  So that helped my understanding.  I've
> > since found some key places in the kernel where registers are defined
> > and interrupts set.  So, conceptually, I have a much better idea of how
> > it needs to happen.  Unfortunately, it needs to be kirkwood / orion
> > getting fdt support, and then adding a dreamplug fdt file.  A lot more
> > work to do it right.
> 
> I have a reasonable idea how kirkwood/orion works. I've done some
> cleanup of the shared code between the different orion devices.
> 
> I guess what i need is the simplest DT configuration needed to get the
> device to boot however still using the bubba3 hard coded platform
> devices. I can then move each platform device one by one into
> DT. However, my initial quick experiments just resulted in instant
> kernel crash...

i've already ported some marvell devices to DT. spi-orion, orion-wdt, rtc-mv 
and mv_cesa. Atm i'm struggling with how to pass kirkwood_mbus_dram_info to 
the device drivers (the old method is to pass it through platform_data)

I hope i find time tomorrow, to upload my git tree and/or post some RFC 
patches.

-- 
Michael

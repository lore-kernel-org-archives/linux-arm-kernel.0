From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 04 Nov 2011 10:01:43 -0400 (EDT)
Subject: orion/kirkwood and device tree
In-Reply-To: <201111032250.59528.michael@walle.cc>
References: <20111031105740.GC29402@lunn.ch>
	<201111022303.04957.michael@walle.cc>
	<20111103184745.GW32165@titan.lakedaemon.net>
	<201111032250.59528.michael@walle.cc>
Message-ID: <alpine.LFD.2.02.1111041000060.3307@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 3 Nov 2011, Michael Walle wrote:

> Am Donnerstag 03 November 2011, 19:47:45 schrieb Jason:
> > Michael,
> > 
> > On Wed, Nov 02, 2011 at 11:03:04PM +0100, Michael Walle wrote:
> > > Am Mittwoch 02 November 2011, 17:50:57 schrieb Jason:
> > > > Michael,
> > > > 
> > > > On Mon, Oct 31, 2011 at 11:50:28PM +0100, Michael Walle wrote:
> > > > > i've already ported some marvell devices to DT. spi-orion, orion-wdt,
> > > > > rtc-mv and mv_cesa. Atm i'm struggling with how to pass
> > > > > kirkwood_mbus_dram_info to the device drivers (the old method is to
> > > > > pass it through platform_data)
> > > > 
> > > > Do you have a public git tree I could pull from, by chance?  I don't
> > > > care about the state, I'd like to learn by example and start pitching
> > > > in.
> > > 
> > > yeah i pushed it to github:
> > > https://github.com/mwalle/linux/tree/kirkwood-devtree
> > 
> > This is great!  I was having trouble figuring out how to do the
> > interrupt controller, and you have that.  I'll look more closely this
> > evening.
> > 
> > My only comment so far is that I think a lot of what you have in
> > lschlv2.dts can be in kirkwood.dtsi.  That way other boards don't have
> > to copy it (serial, spi, ehci, wdt, rtc, crypto).
> yeah i had it there and it should be definitely put back to kirkwood.dtsi. the 
> reason i've put it into lschv2.dts atm is that there is the clock property for 
> every device, which may be different for different platforms.

The clock property should be a separate entity from the actual devices.  
In fact, that would be a good idea for Kirkwood and friends to move to 
the struck clk API.


Nicolas

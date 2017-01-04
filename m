From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 4 Jan 2017 14:41:31 +0100
Subject: [PATCH v3] ARM: dts: turris-omnia: add support for ethernet switch
In-Reply-To: <e1dae939-e209-eccc-00df-b996d03cb8db@suse.de>
References: <20170103152107.GA32450@lunn.ch>
 <20170103193501.4827-1-uwe@kleine-koenig.org>
 <e1dae939-e209-eccc-00df-b996d03cb8db@suse.de>
Message-ID: <20170104134131.GJ10768@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 04, 2017 at 11:49:12AM +0100, Andreas F?rber wrote:
> Hi Uwe,
> 
> Am 03.01.2017 um 20:35 schrieb Uwe Kleine-K?nig:
> > The Turris Omnia features a Marvell MV88E6176 ethernet switch. Add it to
> > the dts.
> > 
> > Signed-off-by: Uwe Kleine-K?nig <uwe@kleine-koenig.org>
> 
> It's still not working for me on next-20170104 with this v3.
> Are there any other patches needed?
> 
> Should all ports LAN0-LAN4 work with the commented-out second cpu node?
> 
> I've been using the WAN port (eth2) just fine. (=eth1 in OpenWrt)
> 
> With this patch, eth0 and eth1 are shown as UP by default. If however I
> enslave eth0 and eth1 in a br-lan bridge, as seen under OpenWrt for
> eth0+eth2, then eth1 is DOWN while eth0 remains UP, and br-lan remains
> DOWN. Same issue if I drop eth0 from the bridge - after a reboot eth1 is
> UP but br-lan is still DOWN.
> I had to manually enable CONFIG_BRIDGE, so maybe I'm missing more kernel
> options? Or did you simply not try using a bridge?

That is not how you use DSA. It is very different to how OpenWRT
swconfig works. The mainline kernel philosophy is that switch
interfaces are just normal linux interfaces.

You need eth0 up, in order that the slave interfaces work. But then
you can use the slave interfaces just like normal Linux
interfaces. You can put an IP address on them. You can put them into a
bridge, etc. But leave eth0 alone, other than having it up.

	Andrew

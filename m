From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu, 6 Feb 2014 13:57:41 -0300
Subject: [PATCH v2 0/5] net: phy: Ethernet PHY powerdown optimization
In-Reply-To: <52F141AE.8010402@gmail.com>
References: <1386513631-11284-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1386926429-28818-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20131217.144313.1563516273987934449.davem@davemloft.net>
 <52F141AE.8010402@gmail.com>
Message-ID: <20140206165740.GA12542@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sebastian,

On Tue, Feb 04, 2014 at 08:38:22PM +0100, Sebastian Hesselbarth wrote:
> On 12/17/2013 08:43 PM, David Miller wrote:
> > From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> > Date: Fri, 13 Dec 2013 10:20:24 +0100
> >
> >> This is v2 of the ethernet PHY power optimization patches to reduce
> >> power consumption of network PHYs with link that are either unused or
> >> the corresponding netdev is down.
> >>
> >> Compared to the last version, this patch set drops a patch to disable
> >> unused PHYs after late initcall, as it is not compatible with a modular
> >> mdio bus [1]. I'll investigate different ways to have a modular mdio bus
> >> driver get notified when driver loading is done.
> >>
> >> Again, a branch with v2 applied to v3.13-rc2 can also be found at
> >> https://github.com/shesselba/linux-dove.git topic/ethphy-power-v2
> >>
> >> [1] http://www.spinics.net/lists/arm-kernel/msg293028.html
> >
> > Series applied, thanks.
> >
[..]
> 
> as expected the above patches create a Linux to bootloader dependency
> that surfaces dumb bootloaders not initializing PHYs correctly.
> 
> Andrew has a Kirkwood based board that does not power-up and restart
> auto-negotiation on the powered down PHY after a warm restart. While
> this specific bootloader allows a soft-workaround by issuing the
> required PHY writes before accessing the interface, others may not.
> 

I'm also having this same issue on Kirkwood USI Topkick, running
v3.14-rc1.
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com

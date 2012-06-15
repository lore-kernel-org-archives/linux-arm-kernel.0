From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 15 Jun 2012 09:14:34 -0400 (EDT)
Subject: [PATCH v3 1/9] clocksource: time-armada-370-xp: Marvell Armada
 370/XP SoC timer driver
In-Reply-To: <20120615115418.GM26034@lunn.ch>
References: <1339746250-26650-1-git-send-email-gregory.clement@free-electrons.com>
 <1339746250-26650-2-git-send-email-gregory.clement@free-electrons.com>
 <20120615104547.GK26034@lunn.ch> <4FDB1EC5.8090602@free-electrons.com>
 <20120615115418.GM26034@lunn.ch>
Message-ID: <alpine.LFD.2.02.1206150909550.23555@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 15 Jun 2012, Andrew Lunn wrote:

> > About calling it orion, it should be mvebu I think.
> 
> I guess that's another discussion. All current device drivers, except
> Ethernet and I2C are called orion. Orion currently means anything
> shared by orion5x, kirkwood, dove, mv78xx0. It seems unlikely we are
> going to rename all the device drivers. So calling it mvebu will just
> add to the confusion, not reduce the confusion. I personally would
> say, anything inside mach-mvebu which is shared by multiple SoCs, can
> be prefixed mvebu_. However, anything outside mach-mvebu should remain
> orion_.

Well, a halfway cleanup is potentially even more confusing than a 
complete one.  So it would be best to also rename "orion" to "mvebu" for 
stuff outside of mach-mvebu.

Your point holds for things which are shared beyond the mvebu SOCs 
though, such as mv643 or sata_mv.


Nicolas

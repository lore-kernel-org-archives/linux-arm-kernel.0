From: michael@walle.cc (Michael Walle)
Date: Mon, 5 Mar 2012 00:22:11 +0100
Subject: [PATCH 3/4] ARM: kirkwood: convert rtc-mv to fdt.
In-Reply-To: <20120304222710.GT11986@titan.lakedaemon.net>
References: <cover.1330625877.git.jason@lakedaemon.net>
 <201203041648.17428.arnd@arndb.de>
 <20120304222710.GT11986@titan.lakedaemon.net>
Message-ID: <201203050022.12085.michael@walle.cc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Sonntag 04 M?rz 2012, 23:27:10 schrieb Jason:
> On Sun, Mar 04, 2012 at 04:48:17PM +0000, Arnd Bergmann wrote:
> > On Sunday 04 March 2012, Michael Walle wrote:
> > > in my older patch series i flagged all converted devices with two
> > > 
> > > compatibility names. Eg:
> > >        { .compatible = "marvell,orion5x-rtc", },
> > >        { .compatible = "marvell,kirkwood-rtc", },
> > > 
> > > IMHO marvell,rtc is i little too general, i guess marvell won't have
> > > only one rtc ;)
> > > 
> > > Other opinions?
> > 
> > Being specific is certainly good, and it may also be a good idea to
> > list the first one it's compatible with in the device tree source.
> > 
> > So the device tree for a 88F6281 soc could list
> > 
> > 	compatible = "marvell,88f6281-rtc", "marvell,kirkwood-rtc",
> > 	"marvell,orion-rtc";
> 
> I'll go ahead and make this style of change throughout.  I assume
> "marvell,88f6281-rtc" would only be for SoC internal devices?  eg, the spi
> driver wouldn't follow that convention.  I'll see if I can dig up a part
> number on it.

following the filename spi-orion.c i guess it should use 'marvell,orion-spi'.

-- 
Michael

From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 28 Jul 2014 09:30:05 -0400
Subject: [PATCH 2/2] V3 ARM: mvebu: Added dts defintion for Lenovo
 Iomega ix4-300d NAS
In-Reply-To: <20140727015509.GB31974@lunn.ch>
References: <1406418490-61502-1-git-send-email-yahoo@perenite.com>
 <20140727015509.GB31974@lunn.ch>
Message-ID: <20140728133005.GO23220@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andrew,

On Sun, Jul 27, 2014 at 03:55:09AM +0200, Andrew Lunn wrote:
> On Sat, Jul 26, 2014 at 04:48:10PM -0700, Benoit Masson wrote:
> > The Lenovo Iomega ix4-300d is a 4-Bay sata NAS with dual Gb,
> >  USB2.0 & 3.0, powered by a Marvell Armada XP MV78230 dual core CPU.
> > 
> > http://shop.lenovo.com/us/en/servers/network-storage/lenovoemc/ix4-300d/
> > Signed-off-by: Benoit Masson <yahoo@perenite.com>
> > ---
> >  arch/arm/boot/dts/Makefile                      |   3 +-
> >  arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts | 285 ++++++++++++++++++++++++
> >  2 files changed, 287 insertions(+), 1 deletion(-)
> >  create mode 100644 arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
> > 
...
> > diff --git a/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts b/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
> > new file mode 100644
> > index 0000000..c82a8e3
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
...
> > +			i2c at 11000 {
> > +				compatible = "marvell,mv64xxx-i2c";
> 
> O.K, this version is good.

Is it?  As Arnd mentioned against the previous version, this overrides
the default compatible property inherited from the dtsi.  Since this is
also compatible with "marvell,mv78230-i2c", I think we should just
delete this line.

Benoit, this is still in V4.  If Andrew agrees, I'll just remove the
line when I apply V4.

> Acked-by: Andrew Lunn <andrew@lunn.ch>

thx,

Jason.

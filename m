From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Sat, 8 Jun 2013 19:57:54 +0200
Subject: [PATCH 4/5] ARM: dts: imx27-phytec-phycore-rdk: Add spidev node
In-Reply-To: <1370712019.891315204@f13.mail.ru>
References: <1370702380-25408-1-git-send-email-shc_work@mail.ru>
 <1370702380-25408-4-git-send-email-shc_work@mail.ru>
 <20130608170840.GK32299@pengutronix.de>
 <1370712019.891315204@f13.mail.ru>
Message-ID: <20130608175754.GM32299@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 08, 2013 at 09:20:19PM +0400, Alexander Shiyan wrote:
> > On Sat, Jun 08, 2013 at 06:39:39PM +0400, Alexander Shiyan wrote:
> > > This patch adds spidev device for spi0.1 which is used on ZigBee
> > > PCM970 connector.  This change will help to use this connector in
> > > userspace.
> > > 
> > > Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> > > ---
> > >  arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > > 
> > > diff --git a/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts b/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
> > > index e7ed978..b2dbcdd 100644
> > > --- a/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
> > > +++ b/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
> > > @@ -17,6 +17,12 @@
> > >  &cspi1 {
> > >  	fsl,spi-num-chipselects = <2>;
> > >  	cs-gpios = <&gpio4 28 0>, <&gpio4 27 0>;
> > > +
> > > +	zigbee: spidev at 1 {
> > > +		compatible = "rohm,dh2228fv";
> > > +		reg = <1>;
> > > +		spi-max-frequency = <0>;
> > 
> > Why specify a speed of 0 here? Also, is there really a dh2228fv
> > connected or is this just a hack to let the Linux spidev driver match?
> 
> Zero in this case is indicates using SPI-controller maximum speed.
> This can be overriden by using SPI_IOC_RD_MAX_SPEED_HZ IOCTL
> for spidev device.
> About using dh2228fv, of course no. Currently this is only one dt entry
> for spidev exist, so yes, this a trick.

Then you should convince the spidev maintainers that whatever really is
connected there should be added to the spidev compatible list. Just
using an arbitrary binding only because the kernel happens to do the
right thing at the moment is not an option.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

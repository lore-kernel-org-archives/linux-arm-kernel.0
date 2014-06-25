From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 25 Jun 2014 14:48:43 +0800
Subject: [PATCH] ARM: dts: add support for Ka-Ro TX51
In-Reply-To: <20140623121839.679f35ee@ipc1.ka-ro>
References: <1402578584-12640-1-git-send-email-LW@KARO-electronics.de>
 <20140618150152.GP8860@dragon> <20140623121839.679f35ee@ipc1.ka-ro>
Message-ID: <20140625064841.GA2224@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 23, 2014 at 12:18:39PM +0200, Lothar Wa?mann wrote:
...
> > > +	phy-handle = <&phy0>;
> > > +	mac-address = [000000000000]; /* will be set by U-Boot */
> > 
> > Shouldn't it be local-mac-address?
> > 
> probably yes, but both 'mac-address' and 'local-mac-address' are being
> set up by U-Boot anyway.

Okay, never mind.  I just realized kernel supports both properties.

...

> > > +&esdhc1 {
> > > +	cd-gpios = <&gpio3 8 GPIO_ACTIVE_LOW>;
> > > +	fsl,wp-controller;
> > 
> > Does it work for you, since the driver does not support it as of today?
> > 
> What driver doesn't support what?
> AFAICT the sdhci-esdhc-imx.c driver supports both of these properties.

That was the case before, but it's not the case since commit
89d7e5c13122 (mmc: sdhci-esdhc-imx: add runtime pm support).

http://thread.gmane.org/gmane.linux.kernel.mmc/27287

...

> > > +	spidev0: spi at 0 {
> > > +		compatible = "spidev";
> > > +		reg = <0>;
> > > +		spi-max-frequency = <54000000>;
> > > +	};
> > > +
> > > +	spidev1: spi at 1 {
> > > +		compatible = "spidev";
> > > +		reg = <1>;
> > > +		spi-max-frequency = <54000000>;
> > > +	};
> > 
> > I'm not sure we should have these two devices.
> > 
> Why not? With this the SPI bus can readily be used with the spidev
> driver from Documentation/spi/spidev_test.c (which is what most of our
> customers are asking for)!

Is this something that has been approved by DT maintainers?  I do not
see "spidev" documented as a compatible in any bindings doc.

Shawn

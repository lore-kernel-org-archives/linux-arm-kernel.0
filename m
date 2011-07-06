From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 6 Jul 2011 12:49:49 -0600
Subject: [RFC PATCH 1/5] OMAP3:I2C: Add device tree nodes for beagle board
In-Reply-To: <20110630142702.GV23145@atomide.com>
References: <1309426647-31587-1-git-send-email-manjugk@ti.com>
	<1309426647-31587-2-git-send-email-manjugk@ti.com>
	<20110630142702.GV23145@atomide.com>
Message-ID: <20110706184949.GI4871@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 30, 2011 at 07:27:02AM -0700, Tony Lindgren wrote:
> Hi,
> 
> Few comments on the .dts data layout below.
> 
> * G, Manjunath Kondaiah <manjugk@ti.com> [110630 02:44]:
> > --- a/arch/arm/boot/dts/omap3-beagle-nunchuck.dts
> > +++ b/arch/arm/boot/dts/omap3-beagle-nunchuck.dts
> > @@ -2,11 +2,6 @@
> >  
> >  / {
> >  	i2c at 48072000 {
> > -		compatible = "ti,omap3-i2c";
> > -		reg = <0x48072000 0x80>;
> > -		#address-cells = <1>;
> > -		#size-cells = <0>;
> > -
> >  		eeprom at 50 {
> >  			compatible = "at,at24c01";
> >  			reg = < 0x50 >;
> 
> The board .dts file should include the omap3 SoC .dts file.
> 
> The omap3 SoC .dts file should have the devices mapped to L3 and L4
> busses, and the then i2c at 1 would just contain the bus offset.
> 
> Then the i2c at 1 entry would be repeated in the board specific
> .dts and tell that the i2c at 1 is enabled.

yup.

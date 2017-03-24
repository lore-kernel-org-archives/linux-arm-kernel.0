From: harninder.rai@nxp.com (Harninder Rai)
Date: Fri, 24 Mar 2017 07:37:12 +0000
Subject: [PATCH][v2] arm64: dts: Add support for FSL's LS1088A SoC
In-Reply-To: <20170324071140.GK30608@dragon>
References: <1490280568-13695-1-git-send-email-harninder.rai@nxp.com>
 <20170324071140.GK30608@dragon>
Message-ID: <VI1PR0402MB286387F4AF0C6FC962D8AC82E63E0@VI1PR0402MB2863.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+
> > +&i2c0 {
> > +	status = "okay";
> > +
> > +	pca9547 at 77 {
> 
> Node name should be generic.  The 'i2c-switch' used in bindings doc example
> might be a better choice?
OK. Will have a look at it
> 
> > +		i2c at 3 {
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +			reg = <0x3>;
> > +
> > +			rtc at 51 {
> > +				compatible = "nxp,pcf2129";
> > +				reg = <0x51>;
> > +				/* IRQ10_B */
> > +				interrupts = <0 150 0x4>;
> 
> Use IRQ_TYPE_XXX for polarity?
OK will make the change
> 
> > +
> > +			temp-sensor at 4c {
> 
> Please sort devices under I2C bus in order of slave address, which is just the
> unit-address/reg here.
Ok. Makes sense.
> 
> > +				compatible = "adi,adt7461a";
> > +				reg = <0x4c>;
> > +			};
> > +		};
> > +	};
> > +};
> > +
> > +&sata0 {
> > +	status = "okay";
> > +};
> > +
> > +&duart0 {
> > +	status = "okay";
> > +};
> 
> Try to keep these labelled nodes sorted alphabetically.
ok
> 
> > +#include "fsl-ls1088a.dtsi"
> > +
> > +/ {
> > +	model = "L1088A RDB Board";
> > +	compatible = "fsl,ls1088a-rdb", "fsl,ls1088a"; };
> > +
> > +&i2c0 {
> > +	status = "okay";
> 
> Have a newline between property list and child node.
Ok. My bad

> > +
> > +	gic: interrupt-controller at 6000000 {
> > +		compatible = "arm,gic-v3";
> > +		#interrupt-cells = <3>;
> > +		interrupt-controller;
> > +		reg = <0x0 0x06000000 0 0x10000>, /* GIC Dist */
> > +		      <0x0 0x06100000 0 0x100000>, /*
> GICR(RD_base+SGI_base)*/
> > +		      <0x0 0x0c0c0000 0 0x2000>, /* GICC */
> > +		      <0x0 0x0c0d0000 0 0x1000>, /* GICH */
> > +		      <0x0 0x0c0e0000 0 0x20000>; /* GICV */
> > +		interrupts = <1 9 0x4>;
> 
> Use define for polarity.
ok
> > +		sata0: sata at 3200000 {
> 
> If there is only one sata, I do not see the point of '0' suffix in the label name.
Yes, I agree

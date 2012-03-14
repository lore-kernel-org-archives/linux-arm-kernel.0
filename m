From: marek.vasut@gmail.com (Marek Vasut)
Date: Wed, 14 Mar 2012 06:56:23 +0100
Subject: [PATCH v1 1/5] ARM: imx28: add basic dt support
In-Reply-To: <20120314054116.GD21337@S2101-09.ap.freescale.net>
References: <1331628428-24017-1-git-send-email-b29396@freescale.com>
 <20120313172351.97C5E3E053B@localhost>
 <20120314054116.GD21337@S2101-09.ap.freescale.net>
Message-ID: <201203140656.24301.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Shawn Guo,

> On Tue, Mar 13, 2012 at 11:23:51AM -0600, Grant Likely wrote:
> ...
> 
> > > +	apb at 80000000 {
> > > +		compatible = "simple-bus";
> > > +		#address-cells = <1>;
> > > +		#size-cells = <1>;
> > > +		reg = <0x80000000 0x80000>;
> > > +		ranges;
> > > +
> > > +		apbh at 80000000 {
> > > +			compatible = "simple-bus";
> > > +			#address-cells = <1>;
> > > +			#size-cells = <1>;
> > > +			reg = <0x80000000 0x3c900>;
> > > +			ranges;
> > > +
> > > +			icoll: interrupt-controller at 80000000 {
> > > +				compatible = "fsl,imx28-icoll";
> > > +				interrupt-controller;
> > > +				#interrupt-cells = <1>;
> > > +				reg = <0x80000000 0x2000>;
> > > +			};
> > > +		};
> > > +
> > > +		apbx at 80040000 {
> > > +			compatible = "simple-bus";
> > > +			#address-cells = <1>;
> > > +			#size-cells = <1>;
> > > +			reg = <0x80040000 0x40000>;
> > > +			ranges;
> > > +
> > > +			uart1: uart at 80074000 {
> > > +				compatible = "arm,pl011", "arm,primecell";
> > > +				reg = <0x80074000 0x2000>;
> > > +				interrupts = <47>;
> > > +			};
> > > +		};
> > 
> > What is the purpose of the apbh and apbx busses?  Will more device nodes
> > get added to them later, or does each only contain a single device?
> 
> Since our ultimate goal is to convert mach-mxs over to device tree,
> I would also suggest we have all the hardware blocks defined in dts
> from the beginning.

Agreed.

Best regards,
Marek Vasut

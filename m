From: ioana.ciornei@nxp.com (Ioana Ciornei)
Date: Thu, 16 Nov 2017 14:24:49 +0000
Subject: [PATCH] arm64: dts: ls1088a: add fsl-mc hardware resource manager
 node
In-Reply-To: <20171116083920.GK25384@dragon>
References: <1510147805-24873-1-git-send-email-ioana.ciornei@nxp.com>
 <20171116083920.GK25384@dragon>
Message-ID: <DB6PR0401MB2264A182C4048471B53BFF89E02E0@DB6PR0401MB2264.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

See comments inline.

> 
> On Wed, Nov 08, 2017 at 03:30:05PM +0200, Ioana Ciornei wrote:
> > Add the fsl-mc node in the LS1088A device tree.
> >
> > Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 62
> ++++++++++++++++++++++++++
> >  1 file changed, 62 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> > index bd80e9a..aa37ffe 100644
> > --- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> > @@ -166,6 +166,68 @@
> >  			     <1 10 IRQ_TYPE_LEVEL_LOW>;/* Hypervisor PPI */
> >  	};
> >
> > +	fsl_mc: fsl-mc at 80c000000 {
> 
> The unit-address of the node should be somehow related to 'reg'
> property.  Can you please help me understand how they are related?

The unit-address of the fsl-mc node is the base address of the MC portal described in the first region of the 'reg' property and formed using the 2 address cells.
Hope this helps.
 
> 
> > +		compatible = "fsl,qoriq-mc";
> > +		reg = <0x00000008 0x0c000000 0 0x40>,	 /* MC portal base */
> > +		      <0x00000000 0x08340000 0 0x40000>; /* MC control reg */
> > +		msi-parent = <&its>;
> > +		#address-cells = <3>;
> > +		#size-cells = <1>;
> > +
> > +		/*
> > +		 * Region type 0x0 - MC portals
> > +		 * Region type 0x1 - QBMAN portals
> > +		 */
> > +		ranges = <0x0 0x0 0x0 0x8 0x0c000000 0x4000000
> > +			  0x1 0x0 0x0 0x8 0x18000000 0x8000000>;
> > +
> > +		dpmacs {
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +
> > +			dpmac1: dpmac at 1 {
> > +				compatible = "fsl,qoriq-mc-dpmac";
> > +				reg = <1>;
> > +			};
> 
> Please have a newline in between nodes.

Will do. 

Should I send a rework of this patch right away or better to wait for the merge window to close?

Ioana 

> 
> Shawn
> 
> > +			dpmac2: dpmac at 2 {
> > +				compatible = "fsl,qoriq-mc-dpmac";
> > +				reg = <2>;
> > +			};
> > +			dpmac3: dpmac at 3 {
> > +				compatible = "fsl,qoriq-mc-dpmac";
> > +				reg = <3>;
> > +			};
> > +			dpmac4: dpmac at 4 {
> > +				compatible = "fsl,qoriq-mc-dpmac";
> > +				reg = <4>;
> > +			};
> > +			dpmac5: dpmac at 5 {
> > +				compatible = "fsl,qoriq-mc-dpmac";
> > +				reg = <5>;
> > +			};
> > +			dpmac6: dpmac at 6 {
> > +				compatible = "fsl,qoriq-mc-dpmac";
> > +				reg = <6>;
> > +			};
> > +			dpmac7: dpmac at 7 {
> > +				compatible = "fsl,qoriq-mc-dpmac";
> > +				reg = <7>;
> > +			};
> > +			dpmac8: dpmac at 8 {
> > +				compatible = "fsl,qoriq-mc-dpmac";
> > +				reg = <8>;
> > +			};
> > +			dpmac9: dpmac at 9 {
> > +				compatible = "fsl,qoriq-mc-dpmac";
> > +				reg = <9>;
> > +			};
> > +			dpmac10: dpmac at 10 {
> > +				compatible = "fsl,qoriq-mc-dpmac";
> > +				reg = <0xa>;
> > +			};
> > +		};
> > +	};
> > +
> >  	psci {
> >  		compatible = "arm,psci-0.2";
> >  		method = "smc";
> > --
> > 1.9.1
> >
> >

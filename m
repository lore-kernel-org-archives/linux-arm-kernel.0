From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 17 Nov 2017 20:35:32 +0800
Subject: [PATCH] arm64: dts: ls1088a: add fsl-mc hardware resource
 manager node
In-Reply-To: <DB6PR0401MB2264A182C4048471B53BFF89E02E0@DB6PR0401MB2264.eurprd04.prod.outlook.com>
References: <1510147805-24873-1-git-send-email-ioana.ciornei@nxp.com>
 <20171116083920.GK25384@dragon>
 <DB6PR0401MB2264A182C4048471B53BFF89E02E0@DB6PR0401MB2264.eurprd04.prod.outlook.com>
Message-ID: <20171117123530.GA25390@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 16, 2017 at 02:24:49PM +0000, Ioana Ciornei wrote:
...
> > > +	fsl_mc: fsl-mc at 80c000000 {
> > 
> > The unit-address of the node should be somehow related to 'reg'
> > property.  Can you please help me understand how they are related?
> 
> The unit-address of the fsl-mc node is the base address of the MC portal described in the first region of the 'reg' property and formed using the 2 address cells.
> Hope this helps.

Ah, sorry, I forgot that the address-cells is 2.

>  
> > 
> > > +		compatible = "fsl,qoriq-mc";
> > > +		reg = <0x00000008 0x0c000000 0 0x40>,	 /* MC portal base */
> > > +		      <0x00000000 0x08340000 0 0x40000>; /* MC control reg */
> > > +		msi-parent = <&its>;
> > > +		#address-cells = <3>;
> > > +		#size-cells = <1>;
> > > +
> > > +		/*
> > > +		 * Region type 0x0 - MC portals
> > > +		 * Region type 0x1 - QBMAN portals
> > > +		 */
> > > +		ranges = <0x0 0x0 0x0 0x8 0x0c000000 0x4000000
> > > +			  0x1 0x0 0x0 0x8 0x18000000 0x8000000>;
> > > +
> > > +		dpmacs {
> > > +			#address-cells = <1>;
> > > +			#size-cells = <0>;
> > > +
> > > +			dpmac1: dpmac at 1 {
> > > +				compatible = "fsl,qoriq-mc-dpmac";
> > > +				reg = <1>;
> > > +			};
> > 
> > Please have a newline in between nodes.
> 
> Will do. 
> 
> Should I send a rework of this patch right away or better to wait for the merge window to close?

Either way is fine, as I will rebase my branch to v4.15-rc1 after merge
window closes.

> > > +			dpmac2: dpmac at 2 {
> > > +				compatible = "fsl,qoriq-mc-dpmac";
> > > +				reg = <2>;
> > > +			};
> > > +			dpmac3: dpmac at 3 {
> > > +				compatible = "fsl,qoriq-mc-dpmac";
> > > +				reg = <3>;
> > > +			};
> > > +			dpmac4: dpmac at 4 {
> > > +				compatible = "fsl,qoriq-mc-dpmac";
> > > +				reg = <4>;
> > > +			};
> > > +			dpmac5: dpmac at 5 {
> > > +				compatible = "fsl,qoriq-mc-dpmac";
> > > +				reg = <5>;
> > > +			};
> > > +			dpmac6: dpmac at 6 {
> > > +				compatible = "fsl,qoriq-mc-dpmac";
> > > +				reg = <6>;
> > > +			};
> > > +			dpmac7: dpmac at 7 {
> > > +				compatible = "fsl,qoriq-mc-dpmac";
> > > +				reg = <7>;
> > > +			};
> > > +			dpmac8: dpmac at 8 {
> > > +				compatible = "fsl,qoriq-mc-dpmac";
> > > +				reg = <8>;
> > > +			};
> > > +			dpmac9: dpmac at 9 {
> > > +				compatible = "fsl,qoriq-mc-dpmac";
> > > +				reg = <9>;
> > > +			};
> > > +			dpmac10: dpmac at 10 {

Just noticed this - the unit-address should be hex number, so it should
be dpmac at a rather than dpmac at 10, I think.

Shawn

> > > +				compatible = "fsl,qoriq-mc-dpmac";
> > > +				reg = <0xa>;
> > > +			};
> > > +		};
> > > +	};
> > > +
> > >  	psci {
> > >  		compatible = "arm,psci-0.2";
> > >  		method = "smc";
> > > --
> > > 1.9.1
> > >
> > >
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

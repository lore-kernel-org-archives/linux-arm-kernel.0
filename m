From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 18 Apr 2016 10:02:52 +0800
Subject: [PATCH 2/2] arm64: dts: ls2080a: fsl-mc dt node updates
In-Reply-To: <HE1PR04MB1641EB3DD445D3AF3F524C3D8D960@HE1PR04MB1641.eurprd04.prod.outlook.com>
References: <1459544080-28598-1-git-send-email-stuart.yoder@nxp.com>
 <20160413055019.GK28903@tiger>
 <HE1PR04MB1641EB3DD445D3AF3F524C3D8D960@HE1PR04MB1641.eurprd04.prod.outlook.com>
Message-ID: <20160418020252.GS28903@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 13, 2016 at 08:39:32PM +0000, Stuart Yoder wrote:
> > > @@ -265,6 +265,93 @@
> > >  			compatible = "fsl,qoriq-mc";
> > >  			reg = <0x00000008 0x0c000000 0 0x40>,	 /* MC portal base */
> > >  			      <0x00000000 0x08340000 0 0x40000>; /* MC control reg */
> > > +			msi-parent = <&its>;
> > > +			#address-cells = <3>;
> > > +			#size-cells = <1>;
> > > +
> > > +			/*
> > > +			 * Region type 0x0 - MC portals
> > > +			 * Region type 0x1 - QBMAN portals
> > > +			 */
> > > +			ranges = <0x0 0x0 0x0 0x8 0x0c000000 0x4000000
> > > +				  0x1 0x0 0x0 0x8 0x18000000 0x8000000>;
> > > +
> > > +			/*
> > > +			 * Define the maximum number of MACs present on the SoC.
> > > +			 * They won't necessarily be all probed, since the
> > > +			 * Data Path Layout file and the MC firmware can put
> > > +			 * fewer actual DPMAC objects on the MC bus.
> > > +			 */
> > > +			dpmacs {
> > > +				#address-cells = <1>;
> > > +				#size-cells = <0>;
> > > +
> > > +				dpmac1: dpmac at 1 {
> > > +					compatible = "fsl,qoriq-mc-dpmac";
> > 
> > I did not see how this compatible is used by kernel driver.
> 
> There is no driver yet, but it will be coming soon.  But, does
> it matter?  Device trees should be describing hardware
> without regards to some specific kernel use of a node or 
> property.

We need to at least have the bindings documented before we can accept it
in dts files.

Shawn

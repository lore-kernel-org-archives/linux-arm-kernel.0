From: stuart.yoder@nxp.com (Stuart Yoder)
Date: Tue, 19 Apr 2016 21:51:51 +0000
Subject: [PATCH 2/2 v2] arm64: dts: ls2080a: fsl-mc dt node updates
In-Reply-To: <20160418025618.GU28903@tiger>
References: <1460581523-32146-1-git-send-email-stuart.yoder@nxp.com>
 <20160418025618.GU28903@tiger>
Message-ID: <HE1PR04MB1641C5D0299D1125A62284048D6C0@HE1PR04MB1641.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Shawn Guo [mailto:shawnguo at kernel.org]
> Sent: Sunday, April 17, 2016 9:56 PM
> To: Stuart Yoder <stuart.yoder@nxp.com>
> Cc: devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org; german.rivera at freescale.com;
> linux-kernel at vger.kernel.org; robh+dt at kernel.org; Yang-Leo Li <leoyang.li@nxp.com>
> Subject: Re: [PATCH 2/2 v2] arm64: dts: ls2080a: fsl-mc dt node updates
> 
> On Wed, Apr 13, 2016 at 04:05:23PM -0500, Stuart Yoder wrote:
> > updates to the fsl-mc node for full functionality:
> >    -msi-parent is needed for interrupt support
> >    -ranges is needed to enable the bus driver to translate bus addresses
> >    -dpmac nodes provide a basis for relating dpmac objects to PHYs
> >
> > Signed-off-by: Stuart Yoder <stuart.yoder@nxp.com>
> > ---
> >
> > -v2: updated comment to remove some extraneous info, added
> >      carriage returns after dpmac nodes
> >
> >  arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi | 98 ++++++++++++++++++++++++++
> >  1 file changed, 98 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi b/arch/arm64/boot/dts/freescale/fsl-
> ls2080a.dtsi
> > index 9d746c6..15498eb 100644
> > --- a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
> > @@ -265,6 +265,104 @@
> >  			compatible = "fsl,qoriq-mc";
> >  			reg = <0x00000008 0x0c000000 0 0x40>,	 /* MC portal base */
> >  			      <0x00000000 0x08340000 0 0x40000>; /* MC control reg */
> > +			msi-parent = <&its>;
> > +			#address-cells = <3>;
> > +			#size-cells = <1>;
> > +
> > +			/*
> > +			 * Region type 0x0 - MC portals
> > +			 * Region type 0x1 - QBMAN portals
> > +			 */
> > +			ranges = <0x0 0x0 0x0 0x8 0x0c000000 0x4000000
> > +				  0x1 0x0 0x0 0x8 0x18000000 0x8000000>;
> > +
> > +			/*
> > +			 * Define the maximum number of MACs present on the SoC.
> > +			 */
> > +			dpmacs {
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +
> > +				dpmac1: dpmac at 1 {
> > +					compatible = "fsl,qoriq-mc-dpmac";
> > +					reg = <1>;
> > +				};
> > +
> > +				dpmac2: dpmac at 2 {
> > +					compatible = "fsl,qoriq-mc-dpmac";
> > +					reg = <2>;
> > +				};
> > +
> > +				dpmac3: dpmac at 3 {
> > +					compatible = "fsl,qoriq-mc-dpmac";
> > +					reg = <3>;
> > +				};
> > +
> > +				dpmac4: dpmac at 4 {
> > +					compatible = "fsl,qoriq-mc-dpmac";
> > +					reg = <4>;
> > +				};
> > +
> > +				dpmac5: dpmac at 5 {
> > +					compatible = "fsl,qoriq-mc-dpmac";
> > +					reg = <5>;
> > +				};
> > +
> > +				dpmac6: dpmac at 6 {
> > +					compatible = "fsl,qoriq-mc-dpmac";
> > +					reg = <6>;
> > +				};
> > +
> > +				dpmac7: dpmac at 7 {
> > +					compatible = "fsl,qoriq-mc-dpmac";
> > +					reg = <7>;
> > +				};
> > +
> > +				dpmac8: dpmac at 8 {
> > +					compatible = "fsl,qoriq-mc-dpmac";
> > +					reg = <8>;
> > +				};
> > +
> > +				dpmac9: dpmac at 9 {
> > +					compatible = "fsl,qoriq-mc-dpmac";
> > +					reg = <9>;
> > +				};
> > +
> > +				dpmac10: dpmac at 10 {
> 
> The unit-address should be same as reg property, i.e. both are in hex
> value.

Ok, will update.  I am going to leave the labels in decimal because
that is how we refer to these mac devices in normal usage and in our
documentation.  ls2080a users expect dpmac10 to be the 10th mac not
the 16th.

Thanks,
Stuart

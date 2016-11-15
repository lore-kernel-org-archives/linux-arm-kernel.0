From: harninder.rai@nxp.com (Harninder Rai)
Date: Tue, 15 Nov 2016 06:46:41 +0000
Subject: [PATCH] arm64: Add DTS support for FSL's LS1012A SoC
In-Reply-To: <DB5PR04MB16887A9480FD29B75735C707E6BF0@DB5PR04MB1688.eurprd04.prod.outlook.com>
References: <1478715118-12848-1-git-send-email-harninder.rai@nxp.com>
 <20161114071308.GL3310@dragon>
 <DB5PR04MB16887A9480FD29B75735C707E6BF0@DB5PR04MB1688.eurprd04.prod.outlook.com>
Message-ID: <DB5PR04MB1688C2A1D449B10C9A0C4DE4E6BF0@DB5PR04MB1688.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Harninder Rai
> Sent: Tuesday, November 15, 2016 12:15 PM
> To: 'Shawn Guo' <shawnguo@kernel.org>
> Cc: devicetree at vger.kernel.org; robh+dt at kernel.org;
> mark.rutland at arm.com; oss at buserror.net; Bhaskar U
> <bhaskar.upadhaya@nxp.com>; linux-arm-kernel at lists.infradead.org
> Subject: RE: [PATCH] arm64: Add DTS support for FSL's LS1012A SoC
> 
> > >  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1043a-qds.dtb
> > >  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1043a-rdb.dtb
> > >  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1046a-qds.dtb
> >
> > It seems that the patch is not generated against mainline kernel.  We
> > do not have fsl-ls1046a-qds.dtb target in mainline kernel.
> You already clarified in the following mail :)
> 
> > > +
> > > +	reg_1p8v: regulator at 0 {
> >
> > Drop the unit-address from node name, and name it like regulator-1p8v.
> Ok. Will take care in V2
> 
> > > +
> > > +&duart0 {
> >
> > Please sort labeled nodes alphabetically.
> Ok Sure
> >
> > > +	status = "okay";
> > > +};
> > > +
> > > +&sai2 {
> > > +	status = "okay";
> > > +};
> >
> > <snip>
> > > +	};
> > > +
> > > +	timer {
> > > +		compatible = "arm,armv8-timer";
> > > +			     /* Physical Secure PPI */
> > > +		interrupts = <1 13 IRQ_TYPE_LEVEL_LOW>,
> > > +			     /* Physical Non-Secure PPI */
> > > +			     <1 14 IRQ_TYPE_LEVEL_LOW>,
> > > +			     /* Virtual PPI */
> > > +			     <1 11 IRQ_TYPE_LEVEL_LOW>,
> > > +			     /* Hypervisor PPI */
> > > +			     <1 10 IRQ_TYPE_LEVEL_LOW>;
> >
> > The following form should be easier for read.
> >
> > 		interrupts = <1 13 IRQ_TYPE_LEVEL_LOW>, /* Physical Secure
> PPI */
> > 			     <1 14 IRQ_TYPE_LEVEL_LOW>, /* Physical Non-
> Secure PPI */
> > 			     <1 11 IRQ_TYPE_LEVEL_LOW>, /* Virtual PPI */
> > 			     <1 10 IRQ_TYPE_LEVEL_LOW>; /* Hypervisor PPI
> */
> >
> >
> Agreed. My bad. Will correct in v2
> 
> > > +		scfg: scfg at 1570000 {
> > > +			compatible = "fsl,ls1012a-scfg", "syscon";
> > > +			reg = <0x0 0x1570000 0x0 0x10000>;
> > > +			big-endian;
> > > +		};
> >
> > Please sort these nodes with unit-address in order of the address.
ok
> >
> > Shawn

From: l.stach@pengutronix.de (Lucas Stach)
Date: Thu, 02 Aug 2018 08:55:00 +0200
Subject: [PATCH 1/2] ARM: dts: imx7d: Add node for PCIe PHY
In-Reply-To: <AM5PR0402MB28501824F60DB56D923758A38C2C0@AM5PR0402MB2850.eurprd04.prod.outlook.com>
References: <20180718194424.8844-1-tpiepho@impinj.com>
 <20180718194424.8844-2-tpiepho@impinj.com>
 <1533119951.20186.5.camel@pengutronix.de>
 <1533144812.2283.227.camel@impinj.com>
 <AM5PR0402MB28501824F60DB56D923758A38C2C0@AM5PR0402MB2850.eurprd04.prod.outlook.com>
Message-ID: <1533192900.20186.19.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, den 02.08.2018, 00:43 +0000 schrieb Richard Zhu:
> > -----Original Message-----
> > > > From: Trent Piepho [mailto:tpiepho at impinj.com]
> > Sent: Thursday, August 2, 2018 1:34 AM
> > > > > > To: l.stach at pengutronix.de; linux-arm-kernel at lists.infradead.org;
> > linux-pci at vger.kernel.org
> > > > > > Cc: Richard Zhu <hongxing.zhu@nxp.com>; shawnguo at kernel.org;
> > > > kernel at pengutronix.de; Fabio Estevam <fabio.estevam@nxp.com>
> > Subject: Re: [PATCH 1/2] ARM: dts: imx7d: Add node for PCIe PHY
> > 
> > On Wed, 2018-08-01 at 12:39 +0200, Lucas Stach wrote:
> > > 
> > > > +This is the PHY associated with the IMX7d PCIe controller.??It's
> > > > used by the
> > > > +PCI-e controller via the fsl,pcie-phy phandle.
> > > > +
> > > > +Required properties:
> > > > +- compatible:
> > > > +	- "fsl,imx-pcie-phy"
> > > 
> > > This is too generic. Please change it to "fsl,imx7-pcie-phy".
> > 
> > Can anyone from NXP tell us if an external PCIe PHY block is present in other
> > IMX designs???I suspect that this is generic, but no design other than imx7d
> > has had any reason to use this PHY register space yet.
> > 
> 
> Hi Trent:
> There is a different PCIe PHY block in imx7d PCIe refer to the imx6.
> So, the standalone memory region is used to map the imx7d PCIe PHY registers.
> Instead of the standalone PHY node, how about to include the PHY registers memory region into PCIe node?
> For example:
> > ???????????????pcie: pcie at 0x33800000 {
> ????????????????????????compatible = "fsl,imx7d-pcie", "snps,dw-pcie";
> ????????????????????????reg = <0x33800000 0x4000>, <0x306d0000 0x10000>, <0x4ff00000 0x80000>;
> ????????????????????????reg-names = "dbi", "phy", "config";

I dislike this solution, as it isn't a correct description of the HW.
Having it as a separate node with it's own compatible, as done in this
patchset, allows us to switch over to a real PHY driver should we ever
have a need for it, all without breaking the DT abstraction again.

Regards,
Lucas 

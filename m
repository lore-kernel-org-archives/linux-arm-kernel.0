From: tpiepho@impinj.com (Trent Piepho)
Date: Wed, 1 Aug 2018 17:33:32 +0000
Subject: [PATCH 1/2] ARM: dts: imx7d: Add node for PCIe PHY
In-Reply-To: <1533119951.20186.5.camel@pengutronix.de>
References: <20180718194424.8844-1-tpiepho@impinj.com>
 <20180718194424.8844-2-tpiepho@impinj.com>
 <1533119951.20186.5.camel@pengutronix.de>
Message-ID: <1533144812.2283.227.camel@impinj.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2018-08-01 at 12:39 +0200, Lucas Stach wrote:
> 
> > +This is the PHY associated with the IMX7d PCIe controller.  It's
> > used by the
> > +PCI-e controller via the fsl,pcie-phy phandle.
> > +
> > +Required properties:
> > +- compatible:
> > +	- "fsl,imx-pcie-phy"
> 
> This is too generic. Please change it to "fsl,imx7-pcie-phy".

Can anyone from NXP tell us if an external PCIe PHY block is present in
other IMX designs?  I suspect that this is generic, but no design other
than imx7d has had any reason to use this PHY register space yet.

If this is specific to this SoC, then maybe it shoudl be fsl,imx7d-
pcie-phy, since the iMX7s has no pcie.

From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 15 Oct 2018 10:27:51 +0200
Subject: [PATCH V2 2/4] arm64: dts: imx: add imx8qxp support
In-Reply-To: <AM0PR04MB42117867A50BB18D8127BE8080FD0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1539527419-23613-1-git-send-email-aisheng.dong@nxp.com>
 <1539527419-23613-3-git-send-email-aisheng.dong@nxp.com>
 <20181015065859.lxevjroly435hlaq@pengutronix.de>
 <AM0PR04MB42117867A50BB18D8127BE8080FD0@AM0PR04MB4211.eurprd04.prod.outlook.com>
Message-ID: <20181015082751.ytuleg67p5pgtnov@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 15, 2018 at 08:08:31AM +0000, A.s. Dong wrote:
> > > +		imx8qx-pm {
> > > +			compatible = "fsl,scu-pd";
> > 
> > I missed this earlier, but there should be a i.MX8qp specific compatible as the
> > SCU API might change for future SoCs.
> > 
> 
> We still do not see that requirement up till now. Not sure if it would be
> possible in the future. I see low possibilities.
> SCU IPC is designed to be generic to all MX8 SCU firmwares.

And i.MX9? i.MX10?

> Even it changes, SCU firmware version control may helps.

It's not the first time that the position of the version field changes with
a newer version.

> 
> > > +			compatible = "fsl,imx7ulp-lpuart";
> > > +			compatible = "fsl,imx7ulp-lpi2c";
> > > +			compatible = "fsl,imx7d-usdhc";
> > 
> > All these lack the most specific imx8qp compatible.
> > 
> 
> Adding them requires binding doc update as well.
> S I suppose they could be added later when the QXP specific features are
> really supported by the drivers.
> Do you think it's okay?

Newer Kernels should work with older device trees, so once you roll out
these compatibles it's too late already.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

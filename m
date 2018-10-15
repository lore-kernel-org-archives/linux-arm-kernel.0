From: aisheng.dong@nxp.com (A.s. Dong)
Date: Mon, 15 Oct 2018 09:03:04 +0000
Subject: [PATCH V2 2/4] arm64: dts: imx: add imx8qxp support
In-Reply-To: <20181015082751.ytuleg67p5pgtnov@pengutronix.de>
References: <1539527419-23613-1-git-send-email-aisheng.dong@nxp.com>
 <1539527419-23613-3-git-send-email-aisheng.dong@nxp.com>
 <20181015065859.lxevjroly435hlaq@pengutronix.de>
 <AM0PR04MB42117867A50BB18D8127BE8080FD0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <20181015082751.ytuleg67p5pgtnov@pengutronix.de>
Message-ID: <AM0PR04MB421179CEB214D46BCDE6ACF280FD0@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Sascha Hauer [mailto:s.hauer at pengutronix.de]
> Sent: Monday, October 15, 2018 4:28 PM
> To: A.s. Dong <aisheng.dong@nxp.com>
> Cc: linux-arm-kernel at lists.infradead.org; Mark Rutland
> <mark.rutland@arm.com>; dongas86 at gmail.com; devicetree at vger.kernel.org;
> catalin.marinas at arm.com; will.deacon at arm.com; robh+dt at kernel.org;
> dl-linux-imx <linux-imx@nxp.com>; kernel at pengutronix.de; Fabio Estevam
> <fabio.estevam@nxp.com>; shawnguo at kernel.org
> Subject: Re: [PATCH V2 2/4] arm64: dts: imx: add imx8qxp support
> 
> On Mon, Oct 15, 2018 at 08:08:31AM +0000, A.s. Dong wrote:
> > > > +		imx8qx-pm {
> > > > +			compatible = "fsl,scu-pd";
> > >
> > > I missed this earlier, but there should be a i.MX8qp specific
> > > compatible as the SCU API might change for future SoCs.
> > >
> >
> > We still do not see that requirement up till now. Not sure if it would
> > be possible in the future. I see low possibilities.
> > SCU IPC is designed to be generic to all MX8 SCU firmwares.
> 
> And i.MX9? i.MX10?
> 

MX8DM MX8DXP

> > Even it changes, SCU firmware version control may helps.
> 
> It's not the first time that the position of the version field changes with a
> newer version.
> 

I understand your worry. 
Up till now all SCU firmware based SoCs are all using one generic IPC driver internally.
And I have not heard a possible changing in the future.
I double checked the SCU firmware implementation that the IPC
Is deigned to be platform independent. So it's less to be changed.
So I wonder if this could be over worried.
Even it is changed, (quite less probility), we still can user version
To distinguish them, just like arm,scpi , arm,scmi. Right?

> >
> > > > +			compatible = "fsl,imx7ulp-lpuart";
> > > > +			compatible = "fsl,imx7ulp-lpi2c";
> > > > +			compatible = "fsl,imx7d-usdhc";
> > >
> > > All these lack the most specific imx8qp compatible.
> > >
> >
> > Adding them requires binding doc update as well.
> > S I suppose they could be added later when the QXP specific features
> > are really supported by the drivers.
> > Do you think it's okay?
> 
> Newer Kernels should work with older device trees, so once you roll out these
> compatibles it's too late already.
> 

The backwards compatible string is used to guarantee a basic function.
Even we add qxp specific compatible string later, it still can work with
backwards function. So I'm not quite get what the real problem is.
And this is the initial support that we don't expect the full features
with such an early device tree, right?

Regards
Dong Aisheng

> Sascha
> 
> --
> Pengutronix e.K.                           |
> |
> Industrial Linux Solutions                 |
> https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fwww.
> pengutronix.de%2F&amp;data=02%7C01%7Caisheng.dong%40nxp.com%7C33
> 7b52b64a9d4b1f2c5c08d632781dcf%7C686ea1d3bc2b4c6fa92cd99c5c30163
> 5%7C0%7C0%7C636751888819600237&amp;sdata=rPKmWjR87ig5Q%2FFfTP
> ZvXtPvLbqt6pZYkINKdhgVwE8%3D&amp;reserved=0  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0
> |
> Amtsgericht Hildesheim, HRA 2686           | Fax:
> +49-5121-206917-5555 |

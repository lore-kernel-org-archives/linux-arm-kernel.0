From: aisheng.dong@nxp.com (A.s. Dong)
Date: Tue, 28 Aug 2018 09:02:28 +0000
Subject: [PATCH V5 0/5] soc: imx: add scu firmware api support
In-Reply-To: <20180828061509.ujjjigfjanprro5i@pengutronix.de>
References: <1534781305-4770-1-git-send-email-aisheng.dong@nxp.com>
 <AM0PR04MB4211F68CCD399243613F8D7B80320@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <AM0PR04MB4211F748DBD1FE64A2B2136980360@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <20180827083310.omqa3kpmj542fu3b@pengutronix.de>
 <AM0PR04MB4211E5D66FD8502278765EC8800B0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <20180828061509.ujjjigfjanprro5i@pengutronix.de>
Message-ID: <AM0PR04MB4211433E7E39455B23A7A75E800A0@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Sascha Hauer [mailto:s.hauer at pengutronix.de]
> Sent: Tuesday, August 28, 2018 2:15 PM
> To: A.s. Dong <aisheng.dong@nxp.com>
> Cc: Jassi Brar <jassisinghbrar@gmail.com>; dongas86 at gmail.com;
> kernel at pengutronix.de; shawnguo at kernel.org; Fabio Estevam
> <fabio.estevam@nxp.com>; dl-linux-imx <linux-imx@nxp.com>;
> linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH V5 0/5] soc: imx: add scu firmware api support
> 
> On Mon, Aug 27, 2018 at 09:59:36AM +0000, A.s. Dong wrote:
> > > -----Original Message-----
> > > From: Sascha Hauer [mailto:s.hauer at pengutronix.de]
> > > Sent: Monday, August 27, 2018 4:33 PM
> > > To: A.s. Dong <aisheng.dong@nxp.com>
> > > Cc: Jassi Brar <jassisinghbrar@gmail.com>; dongas86 at gmail.com;
> > > kernel at pengutronix.de; shawnguo at kernel.org; Fabio Estevam
> > > <fabio.estevam@nxp.com>; dl-linux-imx <linux-imx@nxp.com>;
> > > linux-arm-kernel at lists.infradead.org
> > > Subject: Re: [PATCH V5 0/5] soc: imx: add scu firmware api support
> > >
> > > On Fri, Aug 24, 2018 at 07:36:38AM +0000, A.s. Dong wrote:
> > > > Hi Jassi & Sasha,
> > > >
> > > > Do you have some suggestions about this patch series?
> > >
> > > I still think that the users like clk and pinctrl should directly
> > > call sc_call_rpc(), no need for this shim at all.
> > >
> >
> > Sorry, I'm a bit confuse.
> > What specific shim do you mean not needed?
> >
> > Do you mean we don't need all the SCU SVC APIs (clk/pm/pinctrl/misc
> > and etc) Implemented in this patch series and instead directly
> > implement them in client driver?
> > For example:
> > drivers/soc/imx/sc/svc/pm/rpc_clnt.c
> > sc_err_t sc_pm_get_clock_rate(sc_ipc_t ipc, sc_rsrc_t resource,
> >                               sc_pm_clk_t clk, sc_pm_clock_rate_t
> > *rate) Change to:
> > drivers/clk/imx/scu/scu_clock.c ?
> > sc_err_t sc_pm_get_clock_rate(sc_ipc_t ipc, sc_rsrc_t resource,
> >                               sc_pm_clk_t clk, sc_pm_clock_rate_t
> > *rate)
> 
> That particular function would go into drivers/clk/imx/scu/clk-divider-scu.c
> and probably would be no separate function at all but go into
> clk_divider_scu_recalc_rate(), but yes, that's the idea.
> 

I understanding your point. Just a bit wondering whether it's so worth to do that...
As in my last reply, this is a common way in current kernel and separate well
between the SCU API implementation details and the client users which
somehow can ease our maintain.

Do you think it makes sense?

Regards
Dong Aisheng

> Sascha
> 
> --
> Pengutronix e.K.                           |
> |
> Industrial Linux Solutions                 |
> https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fwww.
> pengutronix.de%2F&amp;data=02%7C01%7Caisheng.dong%40nxp.com%7C64
> 6e546c196147b1e76a08d60cad9e8b%7C686ea1d3bc2b4c6fa92cd99c5c3016
> 35%7C0%7C0%7C636710337160102101&amp;sdata=idEapYpZEVA%2FHP3i%
> 2FfYTBKpPJxaGeZ3jY5RzZgfhdLc%3D&amp;reserved=0  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0
> |
> Amtsgericht Hildesheim, HRA 2686           | Fax:
> +49-5121-206917-5555 |

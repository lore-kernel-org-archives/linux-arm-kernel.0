From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 28 Aug 2018 08:15:09 +0200
Subject: [PATCH V5 0/5] soc: imx: add scu firmware api support
In-Reply-To: <AM0PR04MB4211E5D66FD8502278765EC8800B0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1534781305-4770-1-git-send-email-aisheng.dong@nxp.com>
 <AM0PR04MB4211F68CCD399243613F8D7B80320@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <AM0PR04MB4211F748DBD1FE64A2B2136980360@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <20180827083310.omqa3kpmj542fu3b@pengutronix.de>
 <AM0PR04MB4211E5D66FD8502278765EC8800B0@AM0PR04MB4211.eurprd04.prod.outlook.com>
Message-ID: <20180828061509.ujjjigfjanprro5i@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 27, 2018 at 09:59:36AM +0000, A.s. Dong wrote:
> > -----Original Message-----
> > From: Sascha Hauer [mailto:s.hauer at pengutronix.de]
> > Sent: Monday, August 27, 2018 4:33 PM
> > To: A.s. Dong <aisheng.dong@nxp.com>
> > Cc: Jassi Brar <jassisinghbrar@gmail.com>; dongas86 at gmail.com;
> > kernel at pengutronix.de; shawnguo at kernel.org; Fabio Estevam
> > <fabio.estevam@nxp.com>; dl-linux-imx <linux-imx@nxp.com>;
> > linux-arm-kernel at lists.infradead.org
> > Subject: Re: [PATCH V5 0/5] soc: imx: add scu firmware api support
> > 
> > On Fri, Aug 24, 2018 at 07:36:38AM +0000, A.s. Dong wrote:
> > > Hi Jassi & Sasha,
> > >
> > > Do you have some suggestions about this patch series?
> > 
> > I still think that the users like clk and pinctrl should directly call sc_call_rpc(),
> > no need for this shim at all.
> > 
> 
> Sorry, I'm a bit confuse.
> What specific shim do you mean not needed?
> 
> Do you mean we don't need all the SCU SVC APIs (clk/pm/pinctrl/misc and etc)
> Implemented in this patch series and instead directly implement them in client
> driver?
> For example:
> drivers/soc/imx/sc/svc/pm/rpc_clnt.c
> sc_err_t sc_pm_get_clock_rate(sc_ipc_t ipc, sc_rsrc_t resource,
>                               sc_pm_clk_t clk, sc_pm_clock_rate_t *rate)
> Change to:
> drivers/clk/imx/scu/scu_clock.c ?
> sc_err_t sc_pm_get_clock_rate(sc_ipc_t ipc, sc_rsrc_t resource,
>                               sc_pm_clk_t clk, sc_pm_clock_rate_t *rate)

That particular function would go into drivers/clk/imx/scu/clk-divider-scu.c
and probably would be no separate function at all but go into
clk_divider_scu_recalc_rate(), but yes, that's the idea.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

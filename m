From: aisheng.dong@nxp.com (A.s. Dong)
Date: Mon, 27 Aug 2018 10:21:37 +0000
Subject: [PATCH V5 0/5] soc: imx: add scu firmware api support
In-Reply-To: <AM0PR04MB4211E5D66FD8502278765EC8800B0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1534781305-4770-1-git-send-email-aisheng.dong@nxp.com>
 <AM0PR04MB4211F68CCD399243613F8D7B80320@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <AM0PR04MB4211F748DBD1FE64A2B2136980360@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <20180827083310.omqa3kpmj542fu3b@pengutronix.de>
 <AM0PR04MB4211E5D66FD8502278765EC8800B0@AM0PR04MB4211.eurprd04.prod.outlook.com>
Message-ID: <AM0PR04MB42113BB0FA9E54629339F872800B0@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> From: A.s. Dong
> > From: Sascha Hauer [mailto:s.hauer at pengutronix.de]
> > On Fri, Aug 24, 2018 at 07:36:38AM +0000, A.s. Dong wrote:
> > > Hi Jassi & Sasha,
> > >
> > > Do you have some suggestions about this patch series?
> >
> > I still think that the users like clk and pinctrl should directly call
> > sc_call_rpc(), no need for this shim at all.
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
>

I thought even make client driver to directly to sc_call_rpc(), it may still better to
Make them into a serrate function call like sc_pm_get_clock_rate() but just put
In client driver instead of in the central SCU SVC place.
Not sure the point to do that.
Would you please help clarify a bit more?

Regards
Dong Aisheng

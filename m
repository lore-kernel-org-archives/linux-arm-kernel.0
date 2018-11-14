From: sboyd@kernel.org (Stephen Boyd)
Date: Wed, 14 Nov 2018 15:23:46 -0800
Subject: [PATCH V5 9/9] clk: imx: add imx8qxp clk driver
In-Reply-To: <AM0PR04MB42115A499619B6D650C9728480C70@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1539881347-20871-1-git-send-email-aisheng.dong@nxp.com>
 <1539881347-20871-10-git-send-email-aisheng.dong@nxp.com>
 <153988429912.5275.13469659599335212731@swboyd.mtv.corp.google.com>
 <AM0PR04MB42112CB1324B0994A26AB15D80F80@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <153989556955.53599.9032716427049619310@swboyd.mtv.corp.google.com>
 <AM0PR04MB42112BEEF4DB939F13D6AF1680F90@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <AM0PR04MB42115A499619B6D650C9728480C70@AM0PR04MB4211.eurprd04.prod.outlook.com>
Message-ID: <154223782682.88331.13160210691831603996@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting A.s. Dong (2018-11-10 07:58:00)
> Hi Stephen,
> 
> [...]
> > > > > Where's the DT binding for this device?
> > > >
> > > > Sorry for missed to mention this.
> > > > It's been merged into scu binding doc per Rob's request which has
> > > > already been in Shawn's tree.
> > > >
> > > > Please take a look at here:
> > [...]
> > >
> > > Ok I ask because it's odd to hardcode physical addresses in a clk
> > > driver when those should come from DT in reg properties. Was Rob aware
> > > that this clk node was combining I/O memory and message passing?
> > 
> > Yes, I agree with you. That seems like a special to i.MX case.
> > The problem is not all clocks having a LPCG gate. And those LPCGs are also not
> > continuous and may be shared by many clocks which make things more
> > complicated.
> > I'm not sure parsing from device tree could be better way to do it.
> > Probably need huge changes.
> > 
> 
> I reorganized the driver a lot to address this issue.
> See:
> https://patchwork.kernel.org/cover/10677275/
> We now have a new LPCG clock type and retrieve the LPCG physical
> address from device tree.
> 
> Besides that, as LPCG is moved out from the original SCU gate clocks,
> We have a chance to merge all three type of SCU clocks (divider/gate/mux)
> together into a general SCU clock. (new API introduced imx_clk_scu()).
> Thus, the consumer driver is also simplied a lot which looks better than before.
> Hopefully this can make you happy.
> Please help review that new version.
> 

Ok I'll take a look at the new patch series.

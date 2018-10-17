From: aisheng.dong@nxp.com (A.s. Dong)
Date: Wed, 17 Oct 2018 09:11:03 +0000
Subject: [PATCH V4 02/11] clk: imx: scu: add scu clock common part
In-Reply-To: <153972550584.5275.12112973418888551824@swboyd.mtv.corp.google.com>
References: <1539504194-28289-1-git-send-email-aisheng.dong@nxp.com>
 <1539504194-28289-3-git-send-email-aisheng.dong@nxp.com>
 <153972550584.5275.12112973418888551824@swboyd.mtv.corp.google.com>
Message-ID: <AM0PR04MB42110A50FDC33E66A9DDF63D80FF0@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Stephen Boyd [mailto:sboyd at kernel.org]
> Sent: Wednesday, October 17, 2018 5:32 AM
> Quoting A.s. Dong (2018-10-14 01:07:45)
> > Add scu clock common part which will be used by client clock drivers.
> >
> > Cc: Shawn Guo <shawnguo@kernel.org>
> > Cc: Sascha Hauer <kernel@pengutronix.de>
> > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > Cc: Stephen Boyd <sboyd@kernel.org>
> > Cc: Michael Turquette <mturquette@baylibre.com>
> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > ---
> > ChangeLog:
> > v3->v4:
> >  * scu headfile path change
> > v2->v3:
> >  * no changes
> > v1->v2:
> >  * update function call name
> > ---
> >  drivers/clk/imx/Kconfig       |  2 ++
> >  drivers/clk/imx/Makefile      |  2 ++
> >  drivers/clk/imx/scu/Kconfig   |  5 +++++
> >  drivers/clk/imx/scu/Makefile  |  4 ++++
> > drivers/clk/imx/scu/clk-scu.c | 17 +++++++++++++++++
> > drivers/clk/imx/scu/clk-scu.h | 18 ++++++++++++++++++
> 
> Why is scu nested one level deeper in the imx directory? Can't we just keep
> them all within imx toplevel directory?
> 

Mostly because SCU clocks are totally different from the legacy clocks.
(No much legacy things can be reused) So organized them together in a deeper folder
for clear separation and better maintenance

Do you think we still should put them within imx toplevel directory and mix them with
Legacy clocks?

Regards
Dong Aisheng

> >  6 files changed, 48 insertions(+)
> >  create mode 100644 drivers/clk/imx/scu/Kconfig  create mode 100644
> > drivers/clk/imx/scu/Makefile  create mode 100644
> > drivers/clk/imx/scu/clk-scu.c  create mode 100644
> > drivers/clk/imx/scu/clk-scu.h
> >

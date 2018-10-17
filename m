From: aisheng.dong@nxp.com (A.s. Dong)
Date: Wed, 17 Oct 2018 09:24:05 +0000
Subject: [PATCH V4 10/11] clk: imx: add imx_check_clk_hws helper function
In-Reply-To: <153972567736.5275.15651461252543929480@swboyd.mtv.corp.google.com>
References: <1539504194-28289-1-git-send-email-aisheng.dong@nxp.com>
 <1539504194-28289-11-git-send-email-aisheng.dong@nxp.com>
 <153972567736.5275.15651461252543929480@swboyd.mtv.corp.google.com>
Message-ID: <AM0PR04MB4211A0E210D834DD76DE655980FF0@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> From: Stephen Boyd [mailto:sboyd at kernel.org]
> Sent: Wednesday, October 17, 2018 5:35 AM
> Quoting A.s. Dong (2018-10-14 01:08:13)
> > Add imx_check_clk_hws helper function
> >
> > Cc: Shawn Guo <shawnguo@kernel.org>
> > Cc: Sascha Hauer <kernel@pengutronix.de>
> > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > Cc: Stephen Boyd <sboyd@kernel.org>
> > Cc: Michael Turquette <mturquette@baylibre.com>
> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > ---
> >  drivers/clk/imx/clk-common.h | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/drivers/clk/imx/clk-common.h
> > b/drivers/clk/imx/clk-common.h index e3634a5..01550fd 100644
> > --- a/drivers/clk/imx/clk-common.h
> > +++ b/drivers/clk/imx/clk-common.h
> > @@ -13,4 +13,15 @@ static inline struct clk_hw *imx_clk_hw_fixed(const
> char *name, int rate)
> >         return clk_hw_register_fixed_rate(NULL, name, NULL, 0, rate);
> > }
> >
> > +static inline void imx_check_clk_hws(struct clk_hw *clks[], unsigned
> > +int count) {
> > +       unsigned int i;
> > +
> > +       for (i = 0; i < count; i++) {
> > +               if (IS_ERR(clks[i]))
> > +                       pr_err("i.MX clk %u: register failed with %ld\n",
> > +                               i, PTR_ERR(clks[i]));
> > +       }
> > +}
> 
> And get rid of this too? I don't see the need for layers on top of code snippets.
> Just write them many times in the same driver, and then decide to consolidate
> that logic behind something larger than a few helper functions.

Okay, just see this, then forget my former question in another email talking about
this function. Will remove them all.
Thanks for the suggestion.

Regards
Dong Aisheng

> 
> > +

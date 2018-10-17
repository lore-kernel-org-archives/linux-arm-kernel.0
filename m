From: sboyd@kernel.org (Stephen Boyd)
Date: Wed, 17 Oct 2018 08:17:44 -0700
Subject: [PATCH V4 04/11] clk: imx: scu: add scu clock gpr divider
In-Reply-To: <AM0PR04MB42119987039050D9488EB30F80FF0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1539504194-28289-1-git-send-email-aisheng.dong@nxp.com>
 <1539504194-28289-5-git-send-email-aisheng.dong@nxp.com>
 <153972527843.5275.15123840961402192766@swboyd.mtv.corp.google.com>
 <AM0PR04MB42119987039050D9488EB30F80FF0@AM0PR04MB4211.eurprd04.prod.outlook.com>
Message-ID: <153978946415.5275.1276338045125571065@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting A.s. Dong (2018-10-17 02:03:28)
> > -----Original Message-----
> > From: Stephen Boyd [mailto:sboyd at kernel.org]
> > Sent: Wednesday, October 17, 2018 5:28 AM
> [...]
> > Quoting A.s. Dong (2018-10-14 01:07:52)
> > > +/*
> > > + * clk_divider_scu_recalc_rate - Get clock rate for a SCU clock
> > > + * @hw: clock to get rate for
> > > + * @parent_rate: parent rate provided by common clock framework
> > > + *
> > > + * Gets the current clock rate of a SCU clock. Returns the current
> > > + * clock rate, or zero in failure.
> > > + */
> > > +static unsigned long clk_divider_gpr_scu_recalc_rate(struct clk_hw *hw,
> > > +                                                    unsigned long
> > > +parent_rate) {
> > > +       struct clk_divider_gpr_scu *clk = to_clk_divider_gpr_scu(hw);
> > > +       u32 val;
> > > +       int ret;
> > > +
> > > +       ret = imx_sc_misc_get_control(ccm_ipc_handle, clk->rsrc_id,
> > > +                                     clk->gpr_id, &val);
> > > +       if (ret) {
> > > +               pr_err("%s: failed to get clock rate %d\n",
> > > +                       clk_hw_get_name(hw), ret);
> > > +               return 0;
> > > +       }
> > > +
> > > +       return val ? parent_rate / 2 : parent_rate;
> > 
> > I hope parent_rate can't be zero here.
> > 
> 
> It can be zero, I guess.
> But zero seems safe to me, am I wrong?

No nothing goes wrong so it's fine.

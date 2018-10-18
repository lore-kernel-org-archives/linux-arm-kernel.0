From: abel.vesa@nxp.com (Abel Vesa)
Date: Thu, 18 Oct 2018 09:57:22 +0000
Subject: [PATCH v9 4/5] clk: imx: add imx composite clock
In-Reply-To: <153980589525.5275.9065338436630625817@swboyd.mtv.corp.google.com>
References: <1537785597-26499-1-git-send-email-abel.vesa@nxp.com>
 <1537785597-26499-5-git-send-email-abel.vesa@nxp.com>
 <153980589525.5275.9065338436630625817@swboyd.mtv.corp.google.com>
Message-ID: <20181018095721.eg46zj2srcyd5xy5@fsr-ub1664-175>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 17, 2018 at 12:51:35PM -0700, Stephen Boyd wrote:
> Quoting Abel Vesa (2018-09-24 03:39:56)
> > +       clk = clk_register_composite(NULL, name, parent_names, num_parents,
> > +                                       mux_hw, &clk_mux_ops, div_hw,
> > +                                       &imx_clk_composite_divider_ops, gate_hw,
> > +                                       &clk_gate_ops, flags);
> 
> Didn't I already review this? I'd prefer we move this to using clk_hw
> based APIs and then return the clk pointer if needed.
> 

Yes, you reviewed the v11, so you can ignore this 9th version.

I'll implement all the comments from you in the 12th version before sending.

I'll also switch all clk based register functions call sites
to clk_hw based ones.

Thanks

> > +       if (IS_ERR(clk))
> > +               goto fail;
> > +
> > +       return clk;
> > +
> > +fail:
> > +       kfree(gate);
> > +       kfree(div);
> > +       kfree(mux);
> > +       return clk;
> > +}

-- 

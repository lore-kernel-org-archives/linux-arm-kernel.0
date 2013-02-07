From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Thu, 7 Feb 2013 18:18:09 +0200
Subject: [PATCH v5 09/10] clk: tegra: Implement clocks for Tegra114
In-Reply-To: <20130204104531.GQ2364@tbergstrom-lnx.Nvidia.com>
References: <1359713962-16822-1-git-send-email-pdeschrijver@nvidia.com>
 <1359713962-16822-10-git-send-email-pdeschrijver@nvidia.com>
 <510F5E87.90801@nvidia.com>
 <20130204104531.GQ2364@tbergstrom-lnx.Nvidia.com>
Message-ID: <20130207161809.GQ3073@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> 
> > > +       /* xusb_hs_src */
> > > +       val = readl(clk_base + CLK_SOURCE_XUSB_SS_SRC);
> > > +       val |= BIT(25); /* always select PLLU_60M */
> > > +       writel(val, clk_base + CLK_SOURCE_XUSB_SS_SRC);
> > > +
> > > +       clk = clk_register_fixed_factor(NULL, "xusb_hs_src", "pll_u_60M", 0,
> > > +                                       1, 1);
> > > +       clks[xusb_hs_src] = clk;
> > > +
> > 
> > With device tree we can directly use pll_u_60M, no need to register 
> > clock with fixed factor 1.
> 
> This is true for now. In the future these clocks will need to be dvfs aware
> though. I think it makes sense to have a separate clock then?
> 

As this seems to be a different clock (ie. the hw allows you to select a
different parent), I think keeping this node makes sense.

Cheers,

Peter.

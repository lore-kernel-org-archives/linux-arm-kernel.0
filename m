From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Fri, 18 Oct 2013 15:18:29 +0300
Subject: [PATCH v4 03/15] clk: tegra: common periph_clk_enb_refcnt and clks
In-Reply-To: <CAL1qeaFrm50m0a3csY=04MNQENM_DY5fgBrq5bdsm8dHnLj1gA@mail.gmail.com>
References: <1382013526-12800-1-git-send-email-pdeschrijver@nvidia.com>
 <1382013526-12800-4-git-send-email-pdeschrijver@nvidia.com>
 <CAL1qeaFrm50m0a3csY=04MNQENM_DY5fgBrq5bdsm8dHnLj1gA@mail.gmail.com>
Message-ID: <20131018121829.GA25591@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 18, 2013 at 12:26:20AM +0200, Andrew Bresticker wrote:
> Hi Peter,
> 
> >  static void __init tegra30_clock_init(struct device_node *np)
> >  {
> >         struct device_node *node;
> > -       int i;
> >
> >         clk_base = of_iomap(np, 0);
> >         if (!clk_base) {
> > @@ -1916,8 +1910,11 @@ static void __init tegra30_clock_init(struct device_node *np)
> >                 BUG();
> >         }
> >
> > -       if (tegra_clk_set_periph_banks(5) < 0)
> > +       clks = tegra_clk_init(clk_max, 5);
> > +       if (!clks) {
> > +               WARN_ON(1);
> 
> Really minor nit: it seems strange that we WARN here for t30, but not
> for t114 or t20.

There used to be a warning for all 3, but I removed it and apparently forgot
t30.

Cheers,

Peter.

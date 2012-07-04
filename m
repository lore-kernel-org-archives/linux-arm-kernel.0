From: marvin24@gmx.de (Marc Dietrich)
Date: Wed, 04 Jul 2012 13:51:23 +0200
Subject: [PATCH 1/5] ARM: tegra: set up wlan clocks for tegra dt
In-Reply-To: <1341401013.9009.931.camel@tegra-chromium-2>
References: <1341394488-13169-1-git-send-email-wni@nvidia.com>
 <6135516.CD1aogiCta@fb07-iapwap2>
 <1341401013.9009.931.camel@tegra-chromium-2>
Message-ID: <5111476.afQhu2nTJB@fb07-iapwap2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 4. Juli 2012, 19:23:33 schrieb Wei Ni:
> On Wed, 2012-07-04 at 18:43 +0800, Marc Dietrich wrote:
> > Am Mittwoch, 4. Juli 2012, 17:34:44 schrieb Wei Ni:
> > > Set up the wlan clock tree for Tegra20 and Tegra30.
> > > 
> > > Signed-off-by: Wei Ni <wni@nvidia.com>
> > > ---
> > > 
> > >  arch/arm/mach-tegra/board-dt-tegra20.c |    1 +
> > >  arch/arm/mach-tegra/board-dt-tegra30.c |    1 +
> > >  2 files changed, 2 insertions(+), 0 deletions(-)
> > > 
> > > diff --git a/arch/arm/mach-tegra/board-dt-tegra20.c
> > > b/arch/arm/mach-tegra/board-dt-tegra20.c index 70a19a9..fbcc7d9 100644
> > > --- a/arch/arm/mach-tegra/board-dt-tegra20.c
> > > +++ b/arch/arm/mach-tegra/board-dt-tegra20.c
> > > @@ -78,6 +78,7 @@ static __initdata struct tegra_clk_init_table
> > > tegra_dt_clk_init_table[] = { { "pll_a",      "pll_p_out1",   56448000,
> > > 
> > >   true },
> > >   
> > >  	{ "pll_a_out0", "pll_a",        11289600,       true },
> > >  	{ "cdev1",      NULL,           0,              true },
> > > 
> > > +	{ "blink",      "clk_32k",      32768,          true },
> > 
> > what's the reason to enable this on all boards? Would it make sense to set
> > this to "false" instead?
> 
> This clock is used for the wlan device, it need to be enabled, so that
> the wlan device can be powered on, and then the mmc driver can enumerate
> it.

My question was more why you enable it for *all* boards, even those without 
wlan cards connected to the sdhci. Defining it, but set it to "false", would 
give the driver the chance to enable it only on request. On the other hand, 
the impact on additional power consumption may be too low to measure.

Marc

> > 
> > >  	{ "i2s1",       "pll_a_out0",   11289600,       false},
> > >  	{ "i2s2",       "pll_a_out0",   11289600,       false},
> > >  	{ NULL,		NULL,		0,		0},
> > > 
> > > diff --git a/arch/arm/mach-tegra/board-dt-tegra30.c
> > > b/arch/arm/mach-tegra/board-dt-tegra30.c index 53bf60f..2d73c61 100644
> > > --- a/arch/arm/mach-tegra/board-dt-tegra30.c
> > > +++ b/arch/arm/mach-tegra/board-dt-tegra30.c
> > > @@ -61,6 +61,7 @@ static __initdata struct tegra_clk_init_table
> > > tegra_dt_clk_init_table[] = { { "pll_a_out0",	"pll_a",	11289600,	true },
> > > 
> > >  	{ "extern1",	"pll_a_out0",	0,		true },
> > >  	{ "clk_out_1",	"extern1",	0,		true },
> > > 
> > > +	{ "blink",	"clk_32k",	32768,		true },
> > > 
> > >  	{ "i2s0",	"pll_a_out0",	11289600,	false},
> > >  	{ "i2s1",	"pll_a_out0",	11289600,	false},
> > >  	{ "i2s2",	"pll_a_out0",	11289600,	false},
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-tegra" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

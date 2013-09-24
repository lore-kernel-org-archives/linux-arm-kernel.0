From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Tue, 24 Sep 2013 11:20:04 +0300
Subject: [PATCH 08/12] clk: tegra: move periph clocks to common file
In-Reply-To: <5240890F.6050807@wwwdotorg.org>
References: <1379515331-19427-1-git-send-email-pdeschrijver@nvidia.com>
 <1379515331-19427-9-git-send-email-pdeschrijver@nvidia.com>
 <5240890F.6050807@wwwdotorg.org>
Message-ID: <20130924082004.GJ30013@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 23, 2013 at 08:31:43PM +0200, Stephen Warren wrote:
> On 09/18/2013 08:41 AM, Peter De Schrijver wrote:
> > Introduce a new file for peripheral clocks common between several Tegra
> > SoCs and move Tegra114 to this new infrastructure. Also PLLP and the PLLP_OUT
> > clocks will be initialized here.
> 
> > diff --git a/drivers/clk/tegra/clk-tegra-periph.c b/drivers/clk/tegra/clk-tegra-periph.c
> 
> Similarly here: don't the following differences exist between the SoCs:
> 
> * At least the set of extant peripheral clocks, and perhaps some
> parameters of those clocks.
> 

That's what the tegra_clks is for. If the clock isn't in that table, it won't
be registered.

> * The set of legal parents for some peripheral clocks (?)
> 

If they differ for Tegra20 and Tegra30, we will need some extra clocks here,
which will have a new ID and then only be defined in the tegra_clks for those
SoCs. Alternatively they can stay in the SoC specific files.

> * pll_p frequency table, params, nmp bit positions in registers (?)
> 

Same here. 

> I'd really like to see this series completed so it's obvious exactly
> what data/code really is common, and hence whether it makes sense to
> move everything into a single cross-SoC clk-tegra-periph.c, or whether
> some parts should be kept in the per-SoC files.

There's always the option of keeping things in per-SoC files, even with this
infra. Every SoC can decide which of these 'common clocks' it wants to have
registered.

Cheers,

Peter.

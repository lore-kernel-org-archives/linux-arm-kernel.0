From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Wed, 16 Oct 2013 10:35:14 +0300
Subject: [PATCH v3 10/19] clk: tegra: move audio clk to common file
In-Reply-To: <525D93E8.1010903@wwwdotorg.org>
References: <1381848794-11761-1-git-send-email-pdeschrijver@nvidia.com>
 <1381848794-11761-11-git-send-email-pdeschrijver@nvidia.com>
 <525D93E8.1010903@wwwdotorg.org>
Message-ID: <20131016073514.GB5643@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 15, 2013 at 09:13:44PM +0200, Stephen Warren wrote:
> On 10/15/2013 08:52 AM, Peter De Schrijver wrote:
> > Move audio clocks and PLLA initialization to a common file so it can be used by
> > multiple Tegra SoCs.
> 
> > diff --git a/drivers/clk/tegra/clk-tegra114.c b/drivers/clk/tegra/clk-tegra114.c
> 
> > +static struct tegra_clk tegra114_clks[tegra_clk_max] __initdata = {
> > +	[tegra_clk_rtc] = { .dt_id = TEGRA114_CLK_RTC, .present = true },
> > +	[tegra_clk_timer] = { .dt_id = TEGRA114_CLK_TIMER, .present = true },
> > +	[tegra_clk_uarta] = { .dt_id = TEGRA114_CLK_UARTA, .present = true },
> ...
> > @@ -2194,7 +2167,7 @@ static void __init tegra114_clock_init(struct device_node *np)
> ...
> > +	tegra_audio_clk_init(clk_base, pmc_base, tegra114_clks, &pll_a_params);
> 
> I think it's worth explaining in the commit description why an array of
> not-remotely-audio-related clocks is being passed into an
> audio-clock-initialization function.
> 

This is mostly to avoid a build warning. I could put this in a separate file,
but then, there won't be any user before this is merged.

Cheers,

Peter.

From: josephl@nvidia.com (Joseph Lo)
Date: Thu, 27 Jun 2013 18:12:36 +0800
Subject: [PATCH 08/11] clk: tegra114: add suspend/resume function for
 tegar_cpu_car_ops
In-Reply-To: <51CB432E.9080006@wwwdotorg.org>
References: <1372152475-18617-1-git-send-email-josephl@nvidia.com>
 <1372152475-18617-9-git-send-email-josephl@nvidia.com>
 <51CB432E.9080006@wwwdotorg.org>
Message-ID: <1372327956.9389.33.camel@jlo-ubuntu-64.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-06-27 at 03:38 +0800, Stephen Warren wrote:
> On 06/25/2013 03:27 AM, Joseph Lo wrote:
> > Adding suspend/resume function for tegra_cpu_car_ops. We only save and
> > restore the setting of the clock of CoreSight. Other clocks still need
> > to be taken care by clock driver.
> 
> Mike, can I get an ack to take this through the Tegra tree with the rest
> of this series, for 3.12. Thanks.
> 
> (Nit: There's a typo in the patch subject here too.)
> 
> > diff --git a/drivers/clk/tegra/clk-tegra114.c b/drivers/clk/tegra/clk-tegra114.c
> 
> > +#ifdef CONFIG_PM_SLEEP
> > +static void tegra114_cpu_clock_suspend(void)
> > +{
> > +	/* switch coresite to clk_m, save off original source */
> > +	tegra114_cpu_clk_sctx.clk_csite_src =
> > +				readl(clk_base + CLK_SOURCE_CSITE);
> > +	writel(3<<30, clk_base + CLK_SOURCE_CSITE);
> 
> Don't you need spaces around the << to satisfy checkpatch/coding style?

It didn't cause a warning by checkpatch. But I will fix it in next
version.

Thanks.

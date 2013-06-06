From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Thu, 6 Jun 2013 11:15:42 +0300
Subject: [PATCH 2/4] clk: tegra: override bits for Tegra114 PLLM
In-Reply-To: <51AF5FCE.6090501@wwwdotorg.org>
References: <1370441329-8619-1-git-send-email-pdeschrijver@nvidia.com>
 <1370441329-8619-3-git-send-email-pdeschrijver@nvidia.com>
 <51AF5FCE.6090501@wwwdotorg.org>
Message-ID: <20130606081542.GS3847@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 05, 2013 at 05:57:02PM +0200, Stephen Warren wrote:
> On 06/05/2013 08:08 AM, Peter De Schrijver wrote:
> 
> Commit description?
> 
> > diff --git a/drivers/clk/tegra/clk-tegra114.c b/drivers/clk/tegra/clk-tegra114.c
> 
> > +#ifdef CONFIG_PM_SLEEP
> > +static struct cpu_clk_suspend_context {
> > +	u32 clk_csite_src;
> > +} tegra114_cpu_clk_sctx;
> > +#endif
> 
> That generates:
> 
> drivers/clk/tegra/clk-tegra114.c:263:3: warning: ?tegra114_cpu_clk_sctx?
> defined but not used [-Wunused-variable]

Ah. This should not be part of this patch indeed...

Cheers,

Peter.

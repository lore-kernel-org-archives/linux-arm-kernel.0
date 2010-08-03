From: gadiyar@ti.com (Gadiyar, Anand)
Date: Tue, 3 Aug 2010 09:47:33 +0530
Subject: [PATCH 3/3] arm/clkdev: Allow common struct clk usage
In-Reply-To: <1280473404.511776.487110192782.3.gpush@pororo>
References: <1280473404.510741.308477716705.0.gpush@pororo>
	<1280473404.511776.487110192782.3.gpush@pororo>
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB032194B826@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jeremy Kerr wrote:
> A couple of small changes to allow the common struct clk infrastructure
> on ARM. The common clock API provides clk_put, and we no longer need
> mach/clkdev.h (as we don't need __clk_put anymore).
> 
> Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>
> 
> ---
>  arch/arm/common/clkdev.c |   10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm/common/clkdev.c b/arch/arm/common/clkdev.c
> index e2b2bb6..d7dc1f8 100644
> --- a/arch/arm/common/clkdev.c
> +++ b/arch/arm/common/clkdev.c

<snip>

> @@ -87,14 +90,21 @@ struct clk *clk_get(struct device *dev, 
> const char *con_id)
>  }
>  EXPORT_SYMBOL(clk_get);
>  
> +#ifndef CONFIG_USE_COMMON_STRUCT_CLK
> +/* For the common struct clk case, clk_put is provided by the kernel-wide
> + * API. */

Minor coding-style comment. The preferred style for multi-line
comments is:

/*
 * For the common ...
 * API.
 */

- Anand

From: tony@atomide.com (Tony Lindgren)
Date: Wed, 12 Sep 2012 14:52:32 -0700
Subject: [PATCH 2/2] ARM: AM33XX: hwmod: Add OMAP_INTC_START offset to
 all module int nos
In-Reply-To: <1347484551-11775-3-git-send-email-hvaibhav@ti.com>
References: <1347484551-11775-1-git-send-email-hvaibhav@ti.com>
 <1347484551-11775-3-git-send-email-hvaibhav@ti.com>
Message-ID: <20120912215232.GE5997@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Vaibhav Hiremath <hvaibhav@ti.com> [120912 14:17]:
> With recent migration of omap architectures to SPARSE_IRQ framework,
> it is important to add OMAP_INTC_START to all interrupt numbers
> which will be eventually requested by drivers.
> 
> This is required in order to get AM33XX boot functionality.
> 
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod_33xx_data.c |  168 ++++++++++++++--------------
>  1 files changed, 84 insertions(+), 84 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> index 7b7ed08..3c320f4 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c

You should just have on top of this file:

#define OMAP_INTC_START		0

Then Paul can apply this, and while merging with the sparseirq
changes, the above can be removed.

> @@ -72,7 +72,7 @@ static struct omap_hwmod_class am33xx_emif_hwmod_class = {
>  };
>  
>  static struct omap_hwmod_irq_info am33xx_emif_irqs[] = {
> -	{ .name = "ddrerr0", .irq = 101 },
> +	{ .name = "ddrerr0", .irq = 101 + OMAP_INTC_START },
>  	{ .irq = -1 }
>  };
>  

Then these should be fixed up to have trailing commas
as requested by Russell earlier on several occasions.

Regards,

Tony

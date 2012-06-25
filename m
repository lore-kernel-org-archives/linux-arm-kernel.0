From: tony@atomide.com (Tony Lindgren)
Date: Mon, 25 Jun 2012 03:53:37 -0700
Subject: [PATCH] ARM: omap4: Fix standalone OMAP4 build break
In-Reply-To: <1340365461-25385-1-git-send-email-rnayak@ti.com>
References: <1340365461-25385-1-git-send-email-rnayak@ti.com>
Message-ID: <20120625105336.GD12766@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Rajendra Nayak <rnayak@ti.com> [120622 04:48]:
> Fix the below build error while building OMAP4 standalone
> 
>   CC      arch/arm/mach-omap2/board-flash.o
> arch/arm/mach-omap2/board-flash.c:102: error: redefinition of 'board_onenand_init'
> arch/arm/mach-omap2/board-flash.h:56: note: previous definition of 'board_onenand_init' was here
> make[1]: *** [arch/arm/mach-omap2/board-flash.o] Error 1
> make: *** [arch/arm/mach-omap2] Error 2
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>

Thanks, applying into fixes with the updated description to describe
the regression causing commit.

Tony

> ---
>  arch/arm/mach-omap2/board-flash.c |    5 -----
>  1 files changed, 0 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-flash.c b/arch/arm/mach-omap2/board-flash.c
> index 70a81f9..53c39d2 100644
> --- a/arch/arm/mach-omap2/board-flash.c
> +++ b/arch/arm/mach-omap2/board-flash.c
> @@ -97,11 +97,6 @@ __init board_onenand_init(struct mtd_partition *onenand_parts,
>  
>  	gpmc_onenand_init(&board_onenand_data);
>  }
> -#else
> -void
> -__init board_onenand_init(struct mtd_partition *nor_parts, u8 nr_parts, u8 cs)
> -{
> -}
>  #endif /* CONFIG_MTD_ONENAND_OMAP2 || CONFIG_MTD_ONENAND_OMAP2_MODULE */
>  
>  #if defined(CONFIG_MTD_NAND_OMAP2) || \
> -- 
> 1.7.1
> 

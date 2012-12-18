From: horms@verge.net.au (Simon Horman)
Date: Tue, 18 Dec 2012 11:36:10 +0900
Subject: [PATCH] ARM: shmobile: r8a7779: Fix PFC - MOD_SEL2 missed an entry
In-Reply-To: <1353601737-21641-1-git-send-email-phil.edworthy@renesas.com>
References: <1353601737-21641-1-git-send-email-phil.edworthy@renesas.com>
Message-ID: <20121218023610.GV28065@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 22, 2012 at 04:28:57PM +0000, Phil Edworthy wrote:
> The list of functions selected by the MOD_SEL2 register was missing
> an entry. This caused all entries after this to modify the MOD_SEL2
> register incorrectly.

Laurent, can you handle this in your series?
I believe it removes this file.

> 
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> ---
>  arch/arm/mach-shmobile/pfc-r8a7779.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/pfc-r8a7779.c b/arch/arm/mach-shmobile/pfc-r8a7779.c
> index 9fac32e4..15f6a48 100644
> --- a/arch/arm/mach-shmobile/pfc-r8a7779.c
> +++ b/arch/arm/mach-shmobile/pfc-r8a7779.c
> @@ -2525,7 +2525,7 @@ static struct pinmux_cfg_reg pinmux_config_regs[] = {
>  	    /* SEL_SCIF [2] */
>  	    FN_SEL_SCIF_0, FN_SEL_SCIF_1, FN_SEL_SCIF_2, FN_SEL_SCIF_3,
>  	    /* SEL_CANCLK [2] */
> -	    FN_SEL_CANCLK_0, FN_SEL_CANCLK_1, FN_SEL_CANCLK_2,
> +	    FN_SEL_CANCLK_0, FN_SEL_CANCLK_1, FN_SEL_CANCLK_2, 0,
>  	    /* SEL_CAN0 [1] */
>  	    FN_SEL_CAN0_0, FN_SEL_CAN0_1,
>  	    /* SEL_HSCIF1 [1] */
> -- 
> 1.7.5.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

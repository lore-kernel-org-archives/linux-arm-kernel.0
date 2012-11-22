From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Thu, 22 Nov 2012 18:48:45 +0100
Subject: [PATCH] ARM: shmobile: r8a7779: Fix PFC - MOD_SEL2 missed an entry
In-Reply-To: <1353601737-21641-1-git-send-email-phil.edworthy@renesas.com>
References: <1353601737-21641-1-git-send-email-phil.edworthy@renesas.com>
Message-ID: <2677976.XXZnUJZ9sQ@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 22 November 2012 16:28:57 Phil Edworthy wrote:
> The list of functions selected by the MOD_SEL2 register was missing
> an entry. This caused all entries after this to modify the MOD_SEL2
> register incorrectly.
> 
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Simon, this will conflict with my PFC patch series. As I'm still waiting for 
review and need to send a v2 anyway, please apply this patch to your tree and 
push it for v3.8 if time permits. I'll rebase my series on top of it.

> ---
>  arch/arm/mach-shmobile/pfc-r8a7779.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/pfc-r8a7779.c
> b/arch/arm/mach-shmobile/pfc-r8a7779.c index 9fac32e4..15f6a48 100644
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
-- 
Regards,

Laurent Pinchart

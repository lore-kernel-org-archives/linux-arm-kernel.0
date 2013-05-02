From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 2 May 2013 13:44:53 +0800
Subject: [PATCH] ARM: imx: Change type of ioremap function
In-Reply-To: <1367427653-6068-1-git-send-email-lauraa@codeaurora.org>
References: <1367427653-6068-1-git-send-email-lauraa@codeaurora.org>
Message-ID: <20130502054451.GH3442@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 01, 2013 at 10:00:53AM -0700, Laura Abbott wrote:
> Commit cd024d4245b2bfbd824b911f11a9756d1d6c167d
> (ARM: 7704/1: mm: Use phys_addr_t properly for ioremap functions)
> changed the type of the ioremap functions to actually use phys_addr_t.
> 
> Switch the imx ioremap functions to use phys_addr_t to avoid warnings:
> 
> arch/arm/mach-imx/mm-imx3.c: In function 'imx31_init_early':
> arch/arm/mach-imx/mm-imx3.c:142:22: warning: assignment from incompatible pointer type [enabled by default]
> arch/arm/mach-imx/mm-imx3.c: In function 'imx35_init_early':
> arch/arm/mach-imx/mm-imx3.c:221:22: warning: assignment from incompatible pointer type [enabled by default]
> 
> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>

Applied, thanks.

> ---
>  arch/arm/mach-imx/mm-imx3.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/mm-imx3.c b/arch/arm/mach-imx/mm-imx3.c
> index cefa047..f019f14 100644
> --- a/arch/arm/mach-imx/mm-imx3.c
> +++ b/arch/arm/mach-imx/mm-imx3.c
> @@ -65,7 +65,7 @@ static void imx3_idle(void)
>  		: "=r" (reg));
>  }
>  
> -static void __iomem *imx3_ioremap_caller(unsigned long phys_addr, size_t size,
> +static void __iomem *imx3_ioremap_caller(phys_addr_t phys_addr, size_t size,
>  					 unsigned int mtype, void *caller)
>  {
>  	if (mtype == MT_DEVICE) {
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> hosted by The Linux Foundation
> 

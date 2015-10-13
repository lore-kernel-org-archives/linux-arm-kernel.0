From: a0131933@ti.com (Lokesh Vutla)
Date: Tue, 13 Oct 2015 19:32:16 +0530
Subject: [PATCH] ARM: DRA7: hwmod: Remove elm address space from hwmod data
In-Reply-To: <1444743874-4454-1-git-send-email-fcooper@ti.com>
References: <1444743874-4454-1-git-send-email-fcooper@ti.com>
Message-ID: <561D0EE8.8050100@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tuesday 13 October 2015 07:14 PM, Franklin S Cooper Jr wrote:
> ELM address information is provided by device tree. No longer need
> to include this information within hwmod.

Reviewed-by: Lokesh Vutla <lokeshvutla@ti.com>

Thanks and regards,
Lokesh
> 
> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> index 562247b..ad2cc7a 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> @@ -2566,21 +2566,11 @@ static struct omap_hwmod_ocp_if dra7xx_l3_main_1__hdmi = {
>  	.user		= OCP_USER_MPU | OCP_USER_SDMA,
>  };
>  
> -static struct omap_hwmod_addr_space dra7xx_elm_addrs[] = {
> -	{
> -		.pa_start	= 0x48078000,
> -		.pa_end		= 0x48078fff,
> -		.flags		= ADDR_TYPE_RT
> -	},
> -	{ }
> -};
> -
>  /* l4_per1 -> elm */
>  static struct omap_hwmod_ocp_if dra7xx_l4_per1__elm = {
>  	.master		= &dra7xx_l4_per1_hwmod,
>  	.slave		= &dra7xx_elm_hwmod,
>  	.clk		= "l3_iclk_div",
> -	.addr		= dra7xx_elm_addrs,
>  	.user		= OCP_USER_MPU | OCP_USER_SDMA,
>  };
>  
> 

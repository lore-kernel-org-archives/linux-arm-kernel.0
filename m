From: b-cousson@ti.com (Cousson, Benoit)
Date: Mon, 23 Apr 2012 22:34:29 +0200
Subject: [PATCH] ARM: OMAP4: hwmod data: Update AESS data with memory
 bank area
In-Reply-To: <1335212747-8006-1-git-send-email-s-guiriec@ti.com>
References: <1335212747-8006-1-git-send-email-s-guiriec@ti.com>
Message-ID: <4F95BCD5.3060501@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ lakml and Paul

On 4/23/2012 10:25 PM, Sebastien Guiriec wrote:
> Add AESS memory bank data in hwmod in order to provide memory
> address information to the driver. AESS is divided inside 5
> memory banks than can be accessed directly by MPU or by L3.
> - PMEM: Program memory bank.
> - SMEM: Sample memory bank.
> - CMEM: Coefficients memory bank
> - DMEM: Data memory bank.
> - MPU/DMA: Register of AESS IP.
>
> Signed-off-by: Sebastien Guiriec<s-guiriec@ti.com>

Acked-by: Benoit Cousson <b-cousson@ti.com>

Thanks Seb, I'll take it for my WIP cleanup branch.

Regards,
Benoit

> ---
>   arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   42 ++++++++++++++++++++++++++++
>   1 files changed, 42 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> index 4906129..b0d333a 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -3999,6 +3999,27 @@ static struct omap_hwmod_ocp_if omap44xx_l4_cfg__ocp_wp_noc = {
>
>   static struct omap_hwmod_addr_space omap44xx_aess_addrs[] = {
>   	{
> +		.name		= "dmem",
> +		.pa_start	= 0x40180000,
> +		.pa_end		= 0x4018ffff
> +	},
> +	{
> +		.name		= "cmem",
> +		.pa_start	= 0x401a0000,
> +		.pa_end		= 0x401a1fff
> +	},
> +	{
> +		.name		= "smem",
> +		.pa_start	= 0x401c0000,
> +		.pa_end		= 0x401c5fff
> +	},
> +	{
> +		.name		= "pmem",
> +		.pa_start	= 0x401e0000,
> +		.pa_end		= 0x401e1fff
> +	},
> +	{
> +		.name		= "mpu",
>   		.pa_start	= 0x401f1000,
>   		.pa_end		= 0x401f13ff,
>   		.flags		= ADDR_TYPE_RT
> @@ -4017,6 +4038,27 @@ static struct omap_hwmod_ocp_if omap44xx_l4_abe__aess = {
>
>   static struct omap_hwmod_addr_space omap44xx_aess_dma_addrs[] = {
>   	{
> +		.name		= "dmem_dma",
> +		.pa_start	= 0x49080000,
> +		.pa_end		= 0x4908ffff
> +	},
> +	{
> +		.name		= "cmem_dma",
> +		.pa_start	= 0x490a0000,
> +		.pa_end		= 0x490a1fff
> +	},
> +	{
> +		.name		= "smem_dma",
> +		.pa_start	= 0x490c0000,
> +		.pa_end		= 0x490c5fff
> +	},
> +	{
> +		.name		= "pmem_dma",
> +		.pa_start	= 0x490e0000,
> +		.pa_end		= 0x490e1fff
> +	},
> +	{
> +		.name		= "dma",
>   		.pa_start	= 0x490f1000,
>   		.pa_end		= 0x490f13ff,
>   		.flags		= ADDR_TYPE_RT

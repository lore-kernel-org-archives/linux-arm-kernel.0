From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Sat, 3 Nov 2012 21:45:29 +0530
Subject: [PATCH 05/15] ARM: OMAP2+: AM33XX: Update WKUP_M3 hwmod entry
 for reset status
In-Reply-To: <1351859566-24818-6-git-send-email-vaibhav.bedia@ti.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com>
 <1351859566-24818-6-git-send-email-vaibhav.bedia@ti.com>
Message-ID: <50954321.8010908@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 02 November 2012 06:02 PM, Vaibhav Bedia wrote:
> Add the reset status offset for WKUP_M3 in the hwmod data
>
> Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> ---
>   arch/arm/mach-omap2/omap_hwmod_33xx_data.c |    1 +
>   1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> index 3c235d8..2e470ce 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> @@ -269,6 +269,7 @@ static struct omap_hwmod am33xx_wkup_m3_hwmod = {
>   		.omap4	= {
>   			.clkctrl_offs	= AM33XX_CM_WKUP_WKUP_M3_CLKCTRL_OFFSET,
>   			.rstctrl_offs	= AM33XX_RM_WKUP_RSTCTRL_OFFSET,
> +			.rstst_offs	= AM33XX_RM_WKUP_RSTST_OFFSET,
>   			.modulemode	= MODULEMODE_SWCTRL,
>   		},
>   	},
>
You are adding reset bit in this patch but using it in 4/15. Probably
you can re-order it to keep git bisect happy.

Regards
Santosh

From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Fri, 18 Jan 2013 16:28:49 +0400
Subject: [PATCH 4/9] ARM: OMAP2+: AM33XX: hwmod: Update TPTC0 hwmod with
 the right flags
In-Reply-To: <1358493569-17142-5-git-send-email-vaibhav.bedia@ti.com>
References: <1358493569-17142-1-git-send-email-vaibhav.bedia@ti.com>
 <1358493569-17142-5-git-send-email-vaibhav.bedia@ti.com>
Message-ID: <50F94001.5050703@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 18-01-2013 11:19, Vaibhav Bedia wrote:

> Third Party Transfer Controller (TPTC0) needs to be idled and
> put to standby under SW control. Add the appropriate flags in
> the TPTC0 hwmod entry.

> Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
> Change from RFC version:
> 	Clarify TPTC in the changelog

>   arch/arm/mach-omap2/omap_hwmod_33xx_data.c |    1 +
>   1 files changed, 1 insertions(+), 0 deletions(-)

> diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> index 8280f11..f2f408c 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> @@ -1823,6 +1823,7 @@ static struct omap_hwmod am33xx_tptc0_hwmod = {
>   	.class		= &am33xx_tptc_hwmod_class,
>   	.clkdm_name	= "l3_clkdm",
>   	.mpu_irqs	= am33xx_tptc0_irqs,
> +	.flags		= (HWMOD_SWSUP_SIDLE | HWMOD_SWSUP_MSTANDBY),

    Parens not needed here.

WBR, Sergei

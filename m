From: nm@ti.com (Nishanth Menon)
Date: Mon, 13 Jun 2016 18:31:35 -0500
Subject: [RESEND PATCHv2 08/28] ARM: OMAP2+: clockdomain: add usecounting
 support to autoidle APIs
In-Reply-To: <1465844702-12200-9-git-send-email-t-kristo@ti.com>
References: <1465844702-12200-1-git-send-email-t-kristo@ti.com>
 <1465844702-12200-9-git-send-email-t-kristo@ti.com>
Message-ID: <575F4257.3010108@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/13/2016 02:04 PM, Tero Kristo wrote:
[..]
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c
b/arch/arm/mach-omap2/omap_hwmod.c
> index 0c85f91..635a563 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c

[...]

> @@ -2177,14 +2173,10 @@ static int _enable(struct omap_hwmod *oh)
>  
>  	r = (soc_ops.wait_target_ready) ? soc_ops.wait_target_ready(oh) :
>  		-EINVAL;
> -	if (!r) {
> -		/*
> -		 * Set the clockdomain to HW_AUTO only if the target is ready,
> -		 * assuming that the previous state was HW_AUTO
> -		 */
> -		if (oh->clkdm && hwsup)
> -			clkdm_allow_idle(oh->clkdm);
> +	if (oh->clkdm)
> +		clkdm_allow_idle(oh->clkdm);

Should'nt this be under if (!r) ?

>  
> +	if (!r) {

here?


-- 
Regards,
Nishanth Menon

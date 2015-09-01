From: tony@atomide.com (Tony Lindgren)
Date: Tue, 1 Sep 2015 08:46:09 -0700
Subject: [PATCH] arm: omap2: vc: fix 'or' always true warning
In-Reply-To: <1440756632-14043-1-git-send-email-frans.klaver@xsens.com>
References: <DUB128-W519E183FDD98EF80BD4CB79C6E0@phx.gbl>
 <1440756632-14043-1-git-send-email-frans.klaver@xsens.com>
Message-ID: <20150901154609.GK4215@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Frans Klaver <frans.klaver@xsens.com> [150828 03:14]:
> From: Frans Klaver <fransklaver@gmail.com>
> 
> Fix the warning:
> arch/arm/mach-omap2/vc.c:302:47: warning: logical ?or? of collectively exhaustive tests is always true [-Wlogical-op]
> 
> As we're toggling both CLKREQ and OFFMODE, we should also be checking
> OFFMODE.
> 
> Signed-off-by: Frans Klaver <fransklaver@gmail.com>

Thanks apppying into omap-for-v4.3/fixes.

Tony

> ---
>  arch/arm/mach-omap2/vc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
> index 076fd20d7e5a..807bc79e3e3d 100644
> --- a/arch/arm/mach-omap2/vc.c
> +++ b/arch/arm/mach-omap2/vc.c
> @@ -300,7 +300,7 @@ static void __init omap3_vc_init_pmic_signaling(struct voltagedomain *voltdm)
>  
>  	val = voltdm->read(OMAP3_PRM_POLCTRL_OFFSET);
>  	if (!(val & OMAP3430_PRM_POLCTRL_CLKREQ_POL) ||
> -	    (val & OMAP3430_PRM_POLCTRL_CLKREQ_POL)) {
> +	    (val & OMAP3430_PRM_POLCTRL_OFFMODE_POL)) {
>  		val |= OMAP3430_PRM_POLCTRL_CLKREQ_POL;
>  		val &= ~OMAP3430_PRM_POLCTRL_OFFMODE_POL;
>  		pr_debug("PM: fixing sys_clkreq and sys_off_mode polarity to 0x%x\n",
> -- 
> 2.3.4
> 

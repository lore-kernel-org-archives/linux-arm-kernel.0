From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 4 Jan 2012 11:04:32 -0700
Subject: [PATCH v2 01/10] ARM: OMAP2+: pm: Do not init statically the SR
 and voltage layer with DT
In-Reply-To: <1323439361-1647-2-git-send-email-b-cousson@ti.com>
References: <1323439361-1647-1-git-send-email-b-cousson@ti.com>
 <1323439361-1647-2-git-send-email-b-cousson@ti.com>
Message-ID: <20120104180432.GH15503@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 09, 2011 at 03:02:32PM +0100, Benoit Cousson wrote:
> In the case of DT, the PMIC and SR initialization will be done using
> a completely different mechanism.
> 
> Disable this part if a DT blob is available.
> 
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> Cc: Kevin Hilman <khilman@ti.com>
> ---
>  arch/arm/mach-omap2/pm.c |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
> index 1881fe9..ad4f693 100644
> --- a/arch/arm/mach-omap2/pm.c
> +++ b/arch/arm/mach-omap2/pm.c
> @@ -227,6 +227,14 @@ postcore_initcall(omap2_common_pm_init);
>  
>  static int __init omap2_common_pm_late_init(void)
>  {
> +	/*
> +	 * In the case of DT, the PMIC and SR initialization will be done using
> +	 * a completely different mechanism.
> +	 * Disable this part if a DT blob is available.
> +	 */
> +	if (of_have_populated_dt())
> +		return 0;
> +
>  	/* Init the voltage layer */
>  	omap_pmic_late_init();
>  	omap_voltage_late_init();
> -- 
> 1.7.0.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

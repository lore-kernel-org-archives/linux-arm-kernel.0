From: tony@atomide.com (Tony Lindgren)
Date: Fri, 13 Jan 2017 09:15:37 -0800
Subject: [PATCH 36/37] ARM: DRA7: clockdomain: Change the CLKTRCTRL of
 CM_PCIE_CLKSTCTRL to SW_WKUP
In-Reply-To: <1484216786-17292-37-git-send-email-kishon@ti.com>
References: <1484216786-17292-1-git-send-email-kishon@ti.com>
 <1484216786-17292-37-git-send-email-kishon@ti.com>
Message-ID: <20170113171537.GZ2630@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kishon Vijay Abraham I <kishon@ti.com> [170112 02:35]:
> The PCIe programming sequence in TRM suggests CLKSTCTRL of PCIe should
> be set to SW_WKUP. There are no issues when CLKSTCTRL is set to HW_AUTO
> in RC mode. However in EP mode, the host system is not able to access the
> MEMSPACE and setting the CLKSTCTRL to SW_WKUP fixes it.

I guess ideally in the long run we would set this dynamically based on
the selected mode, right?

Regards,

Tony

> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  arch/arm/mach-omap2/clockdomains7xx_data.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap2/clockdomains7xx_data.c b/arch/arm/mach-omap2/clockdomains7xx_data.c
> index 6c67965..67ebff8 100644
> --- a/arch/arm/mach-omap2/clockdomains7xx_data.c
> +++ b/arch/arm/mach-omap2/clockdomains7xx_data.c
> @@ -524,7 +524,7 @@
>  	.dep_bit	  = DRA7XX_PCIE_STATDEP_SHIFT,
>  	.wkdep_srcs	  = pcie_wkup_sleep_deps,
>  	.sleepdep_srcs	  = pcie_wkup_sleep_deps,
> -	.flags		  = CLKDM_CAN_HWSUP_SWSUP,
> +	.flags		  = CLKDM_CAN_SWSUP,
>  };
>  
>  static struct clockdomain atl_7xx_clkdm = {
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

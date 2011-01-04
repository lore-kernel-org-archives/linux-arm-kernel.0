From: nm@ti.com (Nishanth Menon)
Date: Tue, 04 Jan 2011 12:43:41 -0600
Subject: [PATCH 3/5] omap2plus: voltage: Trivial warning fix 'no return
	statement'
In-Reply-To: <1294165576-15628-4-git-send-email-santosh.shilimkar@ti.com>
References: <1294165576-15628-1-git-send-email-santosh.shilimkar@ti.com>
	<1294165576-15628-2-git-send-email-santosh.shilimkar@ti.com>
	<1294165576-15628-3-git-send-email-santosh.shilimkar@ti.com>
	<1294165576-15628-4-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <4D236A5D.9040803@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Santosh Shilimkar had written, on 01/04/2011 12:26 PM, the following:
[..]
> diff --git a/arch/arm/plat-omap/include/plat/voltage.h b/arch/arm/plat-omap/include/plat/voltage.h
> index 0ff1233..710f4ea 100644
> --- a/arch/arm/plat-omap/include/plat/voltage.h
> +++ b/arch/arm/plat-omap/include/plat/voltage.h
> @@ -134,7 +134,10 @@ void omap_change_voltscale_method(struct voltagedomain *voltdm,
>  int omap_voltage_late_init(void);
>  #else
>  static inline int omap_voltage_register_pmic(struct voltagedomain *voltdm,
> -		struct omap_volt_pmic_info *pmic_info) {}
> +		struct omap_volt_pmic_info *pmic_info)
> +{
> +	return 0;
since we dont really succeed registering the pmic to voltage layer,
return -EINVAL?

[..]
-- 
Regards,
Nishanth Menon

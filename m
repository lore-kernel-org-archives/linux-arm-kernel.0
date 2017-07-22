From: f.fainelli@gmail.com (Florian Fainelli)
Date: Sat, 22 Jul 2017 10:01:10 -0700
Subject: [PATCH v4 1/4] soc: brcmstb: Add Product ID and Family ID helper
 functions
In-Reply-To: <1500646226-10659-2-git-send-email-alcooperx@gmail.com>
References: <1500646226-10659-1-git-send-email-alcooperx@gmail.com>
 <1500646226-10659-2-git-send-email-alcooperx@gmail.com>
Message-ID: <48c39931-6323-625a-3632-7c5ba3f3ca6b@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 07/21/2017 07:10 AM, Al Cooper wrote:
> Signed-off-by: Al Cooper <alcooperx@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

> ---
>  drivers/soc/bcm/brcmstb/common.c    | 12 ++++++++++++
>  include/linux/soc/brcmstb/brcmstb.h | 10 ++++++++++
>  2 files changed, 22 insertions(+)
> 
> diff --git a/drivers/soc/bcm/brcmstb/common.c b/drivers/soc/bcm/brcmstb/common.c
> index b6195fd..184dbf5 100644
> --- a/drivers/soc/bcm/brcmstb/common.c
> +++ b/drivers/soc/bcm/brcmstb/common.c
> @@ -40,6 +40,18 @@ bool soc_is_brcmstb(void)
>  	return of_match_node(brcmstb_machine_match, root) != NULL;
>  }
>  
> +u32 brcmstb_get_family_id(void)
> +{
> +	return family_id;
> +}
> +EXPORT_SYMBOL(brcmstb_get_family_id);
> +
> +u32 brcmstb_get_product_id(void)
> +{
> +	return product_id;
> +}
> +EXPORT_SYMBOL(brcmstb_get_product_id);
> +
>  static const struct of_device_id sun_top_ctrl_match[] = {
>  	{ .compatible = "brcm,bcm7125-sun-top-ctrl", },
>  	{ .compatible = "brcm,bcm7346-sun-top-ctrl", },
> diff --git a/include/linux/soc/brcmstb/brcmstb.h b/include/linux/soc/brcmstb/brcmstb.h
> index 337ce41..23e4dc9 100644
> --- a/include/linux/soc/brcmstb/brcmstb.h
> +++ b/include/linux/soc/brcmstb/brcmstb.h
> @@ -1,10 +1,20 @@
>  #ifndef __BRCMSTB_SOC_H
>  #define __BRCMSTB_SOC_H
>  
> +#define BRCM_ID(reg)	((u32)reg >> 28 ? (u32)reg >> 16 : (u32)reg >> 8)
> +#define BRCM_REV(reg)	((u32)reg & 0xff)
> +
>  /*
>   * Bus Interface Unit control register setup, must happen early during boot,
>   * before SMP is brought up, called by machine entry point.
>   */
>  void brcmstb_biuctrl_init(void);
>  
> +/*
> + * Helper functions for getting family or product id from the
> + * SoC driver.
> + */
> +u32 brcmstb_get_family_id(void);
> +u32 brcmstb_get_product_id(void);
> +
>  #endif /* __BRCMSTB_SOC_H */
> 

-- 
Florian

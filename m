From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 26 Feb 2016 14:58:15 +0100
Subject: [PATCH] bsp: add SoC device to brcmstb
In-Reply-To: <1456445947-9079-1-git-send-email-justinpopo6@gmail.com>
References: <1456445947-9079-1-git-send-email-justinpopo6@gmail.com>
Message-ID: <4679582.DyKPu0pJrQ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 25 February 2016 16:19:07 Justin Chen wrote:
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
> -- 

Please remove the declarations from the header file and make the
variable local to this file, to make sure no other driver accidentally
accesses them.

	Arnd

From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 18 Nov 2016 18:55:48 +0000
Subject: [PATCH] mfd: twl-core: export twl_get_regmap
In-Reply-To: <1478950693-13959-1-git-send-email-Nicolae_Rosia@mentor.com>
References: <1478950693-13959-1-git-send-email-Nicolae_Rosia@mentor.com>
Message-ID: <20161118185548.GA23246@dell.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 12 Nov 2016, Nicolae Rosia wrote:

> We want to get rid of global twl_i2c_{write/read}.
> As a first step, allow clients to get the regmap and write directly

What's stopping you from passing it through device data?

> Signed-off-by: Nicolae Rosia <Nicolae_Rosia@mentor.com>
> ---
>  drivers/mfd/twl-core.c  | 3 ++-
>  include/linux/i2c/twl.h | 2 ++
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
> index c64615d..49e6a4b 100644
> --- a/drivers/mfd/twl-core.c
> +++ b/drivers/mfd/twl-core.c
> @@ -421,7 +421,7 @@ EXPORT_SYMBOL(twl_rev);
>   *
>   * Returns the regmap pointer or NULL in case of failure.
>   */
> -static struct regmap *twl_get_regmap(u8 mod_no)
> +struct regmap *twl_get_regmap(u8 mod_no)
>  {
>  	int sid;
>  	struct twl_client *twl;
> @@ -440,6 +440,7 @@ static struct regmap *twl_get_regmap(u8 mod_no)
>  
>  	return twl->regmap;
>  }
> +EXPORT_SYMBOL(twl_get_regmap);
>  
>  /**
>   * twl_i2c_write - Writes a n bit register in TWL4030/TWL5030/TWL60X0
> diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
> index 9ad7828..4c43cdb3 100644
> --- a/include/linux/i2c/twl.h
> +++ b/include/linux/i2c/twl.h
> @@ -174,6 +174,8 @@ static inline int twl_class_is_ ##class(void)	\
>  TWL_CLASS_IS(4030, TWL4030_CLASS_ID)
>  TWL_CLASS_IS(6030, TWL6030_CLASS_ID)
>  
> +struct regmap *twl_get_regmap(u8 mod_no);
> +
>  /* Set the regcache bypass for the regmap associated with the nodule */
>  int twl_set_regcache_bypass(u8 mod_no, bool enable);
>  

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

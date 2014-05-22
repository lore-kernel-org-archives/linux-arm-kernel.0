From: jay.aurabind@gmail.com (Jay Aurabind)
Date: Thu, 22 May 2014 16:06:43 +0530
Subject: [PATCH] mfd: abx500-core: Remove unused function
 abx500_dump_all_banks()
In-Reply-To: <1400750311-15323-1-git-send-email-lee.jones@linaro.org>
References: <1400750311-15323-1-git-send-email-lee.jones@linaro.org>
Message-ID: <537DD33B.6070401@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/22/2014 02:48 PM, Lee Jones wrote:
> abx500_dump_all_banks() has no callers in the kernel, so it's probably
> safe to remove it.
> 
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/mfd/abx500-core.c | 20 --------------------
>  1 file changed, 20 deletions(-)
> 
> diff --git a/drivers/mfd/abx500-core.c b/drivers/mfd/abx500-core.c
> index d6d0ec4..fe41899 100644
> --- a/drivers/mfd/abx500-core.c
> +++ b/drivers/mfd/abx500-core.c
> @@ -151,26 +151,6 @@ int abx500_startup_irq_enabled(struct device *dev, unsigned int irq)
>  }
>  EXPORT_SYMBOL(abx500_startup_irq_enabled);
>  
> -int abx500_dump_all_banks(void)
> -{
> -	struct abx500_ops *ops;
> -	struct device *dummy_child;
> -	struct abx500_device_entry *dev_entry;
> -
> -	dummy_child = kzalloc(sizeof(struct device), GFP_KERNEL);
> -	if (!dummy_child)
> -		return -ENOMEM;
> -	list_for_each_entry(dev_entry, &abx500_list, list) {
> -		dummy_child->parent = dev_entry->dev;
> -		ops = &dev_entry->ops;
> -
> -		if ((ops != NULL) && (ops->dump_all_banks != NULL))
> -			ops->dump_all_banks(dummy_child);
> -	}
> -	kfree(dummy_child);
> -}
> -EXPORT_SYMBOL(abx500_dump_all_banks);
> -
>  MODULE_AUTHOR("Mattias Wallin <mattias.wallin@stericsson.com>");
>  MODULE_DESCRIPTION("ABX500 core driver");
>  MODULE_LICENSE("GPL");
> 
Sorry for top posting previously, I was using gmail web interface. Looks
like you forgot to remove this function's declaration from
include/linux/mfd/abx500.h

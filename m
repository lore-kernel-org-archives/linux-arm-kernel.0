From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 22 May 2014 11:51:55 +0100
Subject: [PATCH] mfd: abx500-core: Remove unused function
 abx500_dump_all_banks()
In-Reply-To: <537DD33B.6070401@gmail.com>
References: <1400750311-15323-1-git-send-email-lee.jones@linaro.org>
 <537DD33B.6070401@gmail.com>
Message-ID: <20140522105155.GR6679@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > abx500_dump_all_banks() has no callers in the kernel, so it's probably
> > safe to remove it.
> > 
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/mfd/abx500-core.c | 20 --------------------
> >  1 file changed, 20 deletions(-)
> > 
> > diff --git a/drivers/mfd/abx500-core.c b/drivers/mfd/abx500-core.c
> > index d6d0ec4..fe41899 100644
> > --- a/drivers/mfd/abx500-core.c
> > +++ b/drivers/mfd/abx500-core.c
> > @@ -151,26 +151,6 @@ int abx500_startup_irq_enabled(struct device *dev, unsigned int irq)
> >  }
> >  EXPORT_SYMBOL(abx500_startup_irq_enabled);
> >  
> > -int abx500_dump_all_banks(void)
> > -{
> > -	struct abx500_ops *ops;
> > -	struct device *dummy_child;
> > -	struct abx500_device_entry *dev_entry;
> > -
> > -	dummy_child = kzalloc(sizeof(struct device), GFP_KERNEL);
> > -	if (!dummy_child)
> > -		return -ENOMEM;
> > -	list_for_each_entry(dev_entry, &abx500_list, list) {
> > -		dummy_child->parent = dev_entry->dev;
> > -		ops = &dev_entry->ops;
> > -
> > -		if ((ops != NULL) && (ops->dump_all_banks != NULL))
> > -			ops->dump_all_banks(dummy_child);
> > -	}
> > -	kfree(dummy_child);
> > -}
> > -EXPORT_SYMBOL(abx500_dump_all_banks);
> > -
> >  MODULE_AUTHOR("Mattias Wallin <mattias.wallin@stericsson.com>");
> >  MODULE_DESCRIPTION("ABX500 core driver");
> >  MODULE_LICENSE("GPL");
> > 
> Sorry for top posting previously, I was using gmail web interface. Looks
> like you forgot to remove this function's declaration from
> include/linux/mfd/abx500.h

You're right, good spot.

Will fix.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

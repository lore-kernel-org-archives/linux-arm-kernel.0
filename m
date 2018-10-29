From: tony@atomide.com (Tony Lindgren)
Date: Mon, 29 Oct 2018 08:02:27 -0700
Subject: linux-next: manual merge of the arm-soc tree with Linus' tree
In-Reply-To: <20181029101401.5687153e@canb.auug.org.au>
References: <20181029101401.5687153e@canb.auug.org.au>
Message-ID: <20181029150227.GA56754@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Stephen Rothwell <sfr@canb.auug.org.au> [181028 23:14]:
> Hi all,
> 
> Today's linux-next merge of the arm-soc tree got a conflict in:
> 
>   include/linux/platform_data/gpio-omap.h
> 
> between commit:
> 
>   b764a5863fd8 ("gpio: omap: Remove custom PM calls and use cpu_pm instead")
> 
> from Linus' tree and commit:
> 
>   26683316c92a ("ARM: OMAP1: ams-delta-fiq: Use <linux/platform_data/gpio-omap.h>")
> 
> from the arm-soc tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Thanks it probably makes sense to merge in the immutable gpio branch
also into arm-soc tree that Linus Walleij has set up earlier. That's the
ib-omap branch at commit 5284521a290e ("gpio: omap: Get rid of
pm_runtime_irq_safe()").

Regards,

Tony

> diff --cc include/linux/platform_data/gpio-omap.h
> index 8485c6a9a383,ed071f76b642..000000000000
> --- a/include/linux/platform_data/gpio-omap.h
> +++ b/include/linux/platform_data/gpio-omap.h
> @@@ -205,4 -206,18 +208,6 @@@ struct omap_gpio_platform_data 
>   	int (*get_context_loss_count)(struct device *dev);
>   };
>   
>  -#if IS_BUILTIN(CONFIG_GPIO_OMAP)
>  -extern void omap2_gpio_prepare_for_idle(int off_mode);
>  -extern void omap2_gpio_resume_after_idle(void);
>  -#else
>  -static inline void omap2_gpio_prepare_for_idle(int off_mode)
>  -{
>  -}
>  -
>  -static inline void omap2_gpio_resume_after_idle(void)
>  -{
>  -}
>  -#endif
> + #endif /* __ASSEMBLER__ */
> + 
>   #endif

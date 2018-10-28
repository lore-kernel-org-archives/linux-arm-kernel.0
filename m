From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 29 Oct 2018 10:14:01 +1100
Subject: linux-next: manual merge of the arm-soc tree with Linus' tree
Message-ID: <20181029101401.5687153e@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in:

  include/linux/platform_data/gpio-omap.h

between commit:

  b764a5863fd8 ("gpio: omap: Remove custom PM calls and use cpu_pm instead")

from Linus' tree and commit:

  26683316c92a ("ARM: OMAP1: ams-delta-fiq: Use <linux/platform_data/gpio-omap.h>")

from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

-- 
Cheers,
Stephen Rothwell

diff --cc include/linux/platform_data/gpio-omap.h
index 8485c6a9a383,ed071f76b642..000000000000
--- a/include/linux/platform_data/gpio-omap.h
+++ b/include/linux/platform_data/gpio-omap.h
@@@ -205,4 -206,18 +208,6 @@@ struct omap_gpio_platform_data 
  	int (*get_context_loss_count)(struct device *dev);
  };
  
 -#if IS_BUILTIN(CONFIG_GPIO_OMAP)
 -extern void omap2_gpio_prepare_for_idle(int off_mode);
 -extern void omap2_gpio_resume_after_idle(void);
 -#else
 -static inline void omap2_gpio_prepare_for_idle(int off_mode)
 -{
 -}
 -
 -static inline void omap2_gpio_resume_after_idle(void)
 -{
 -}
 -#endif
+ #endif /* __ASSEMBLER__ */
+ 
  #endif
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 488 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181029/1efa1939/attachment.sig>

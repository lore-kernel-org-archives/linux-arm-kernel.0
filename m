From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Wed, 10 Apr 2013 17:10:01 +1000
Subject: linux-next: manual merge of the arm-soc tree with the pinctrl tree
Message-ID: <20130410171001.d485e70b48cd1a64dd2a6343@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got conflicts in
drivers/pinctrl/pinctrl-samsung.c and drivers/pinctrl/pinctrl-samsung.h
between commit 61dd72613177 ("pinctrl: Add pinctrl-s3c64xx driver") from
the pinctrl tree and commit f67faf487fc1 ("pinctrl: exynos: add
exynos5250 SoC specific data") from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc drivers/pinctrl/pinctrl-samsung.c
index 4f54faf,fe7ace2..0000000
--- a/drivers/pinctrl/pinctrl-samsung.c
+++ b/drivers/pinctrl/pinctrl-samsung.c
@@@ -970,11 -948,8 +970,13 @@@ static const struct of_device_id samsun
  		.data = (void *)exynos4210_pin_ctrl },
  	{ .compatible = "samsung,exynos4x12-pinctrl",
  		.data = (void *)exynos4x12_pin_ctrl },
 +#endif
 +#ifdef CONFIG_PINCTRL_S3C64XX
 +	{ .compatible = "samsung,s3c64xx-pinctrl",
 +		.data = s3c64xx_pin_ctrl },
 +#endif
+ 	{ .compatible = "samsung,exynos5250-pinctrl",
+ 		.data = (void *)exynos5250_pin_ctrl },
  	{},
  };
  MODULE_DEVICE_TABLE(of, samsung_pinctrl_dt_match);
diff --cc drivers/pinctrl/pinctrl-samsung.h
index 45f27b4,ee964aa..0000000
--- a/drivers/pinctrl/pinctrl-samsung.h
+++ b/drivers/pinctrl/pinctrl-samsung.h
@@@ -244,6 -237,6 +244,7 @@@ struct samsung_pmx_func 
  /* list of all exported SoC specific data */
  extern struct samsung_pin_ctrl exynos4210_pin_ctrl[];
  extern struct samsung_pin_ctrl exynos4x12_pin_ctrl[];
 +extern struct samsung_pin_ctrl s3c64xx_pin_ctrl[];
+ extern struct samsung_pin_ctrl exynos5250_pin_ctrl[];
  
  #endif /* __PINCTRL_SAMSUNG_H */

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130410/7cccf4bf/attachment.sig>

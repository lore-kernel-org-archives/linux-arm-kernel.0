From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 4 Oct 2017 13:12:55 +0200
Subject: [PATCH 2/2] ARM: SAMSUNG: Improve a size determination in 13 functions
In-Reply-To: <75c352ad-c51e-2e63-2f93-0f14522ff09c@users.sourceforge.net>
References: <75c352ad-c51e-2e63-2f93-0f14522ff09c@users.sourceforge.net>
Message-ID: <7f196313-ad49-2cd8-e45f-be487e089547@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 4 Oct 2017 09:52:33 +0200

Replace the specification of data structures by pointer dereferences
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/arm/plat-samsung/adc.c  |  4 ++--
 arch/arm/plat-samsung/devs.c | 33 +++++++++++----------------------
 2 files changed, 13 insertions(+), 24 deletions(-)

diff --git a/arch/arm/plat-samsung/adc.c b/arch/arm/plat-samsung/adc.c
index f8d6206e4daa..e9de9e92ce01 100644
--- a/arch/arm/plat-samsung/adc.c
+++ b/arch/arm/plat-samsung/adc.c
@@ -238,7 +238,7 @@ struct s3c_adc_client *s3c_adc_register(struct platform_device *pdev,
 	if (!pdev)
 		return ERR_PTR(-EINVAL);
 
-	client = kzalloc(sizeof(struct s3c_adc_client), GFP_KERNEL);
+	client = kzalloc(sizeof(*client), GFP_KERNEL);
 	if (!client)
 		return ERR_PTR(-ENOMEM);
 
@@ -342,7 +342,7 @@ static int s3c_adc_probe(struct platform_device *pdev)
 	int ret;
 	unsigned tmp;
 
-	adc = devm_kzalloc(dev, sizeof(struct adc_device), GFP_KERNEL);
+	adc = devm_kzalloc(dev, sizeof(*adc), GFP_KERNEL);
 	if (!adc)
 		return -ENOMEM;
 
diff --git a/arch/arm/plat-samsung/devs.c b/arch/arm/plat-samsung/devs.c
index dc269d9143bc..5668e4eb03df 100644
--- a/arch/arm/plat-samsung/devs.c
+++ b/arch/arm/plat-samsung/devs.c
@@ -339,8 +339,7 @@ void __init s3c_i2c0_set_platdata(struct s3c2410_platform_i2c *pd)
 		pd->bus_num = 0;
 	}
 
-	npd = s3c_set_platdata(pd, sizeof(struct s3c2410_platform_i2c),
-			       &s3c_device_i2c0);
+	npd = s3c_set_platdata(pd, sizeof(*npd), &s3c_device_i2c0);
 
 	if (!npd->cfg_gpio)
 		npd->cfg_gpio = s3c_i2c0_cfg_gpio;
@@ -368,8 +367,7 @@ void __init s3c_i2c1_set_platdata(struct s3c2410_platform_i2c *pd)
 		pd->bus_num = 1;
 	}
 
-	npd = s3c_set_platdata(pd, sizeof(struct s3c2410_platform_i2c),
-			       &s3c_device_i2c1);
+	npd = s3c_set_platdata(pd, sizeof(*npd), &s3c_device_i2c1);
 
 	if (!npd->cfg_gpio)
 		npd->cfg_gpio = s3c_i2c1_cfg_gpio;
@@ -398,8 +396,7 @@ void __init s3c_i2c2_set_platdata(struct s3c2410_platform_i2c *pd)
 		pd->bus_num = 2;
 	}
 
-	npd = s3c_set_platdata(pd, sizeof(struct s3c2410_platform_i2c),
-			       &s3c_device_i2c2);
+	npd = s3c_set_platdata(pd, sizeof(*npd), &s3c_device_i2c2);
 
 	if (!npd->cfg_gpio)
 		npd->cfg_gpio = s3c_i2c2_cfg_gpio;
@@ -428,8 +425,7 @@ void __init s3c_i2c3_set_platdata(struct s3c2410_platform_i2c *pd)
 		pd->bus_num = 3;
 	}
 
-	npd = s3c_set_platdata(pd, sizeof(struct s3c2410_platform_i2c),
-			       &s3c_device_i2c3);
+	npd = s3c_set_platdata(pd, sizeof(*npd), &s3c_device_i2c3);
 
 	if (!npd->cfg_gpio)
 		npd->cfg_gpio = s3c_i2c3_cfg_gpio;
@@ -458,8 +454,7 @@ void __init s3c_i2c4_set_platdata(struct s3c2410_platform_i2c *pd)
 		pd->bus_num = 4;
 	}
 
-	npd = s3c_set_platdata(pd, sizeof(struct s3c2410_platform_i2c),
-			       &s3c_device_i2c4);
+	npd = s3c_set_platdata(pd, sizeof(*npd), &s3c_device_i2c4);
 
 	if (!npd->cfg_gpio)
 		npd->cfg_gpio = s3c_i2c4_cfg_gpio;
@@ -488,8 +483,7 @@ void __init s3c_i2c5_set_platdata(struct s3c2410_platform_i2c *pd)
 		pd->bus_num = 5;
 	}
 
-	npd = s3c_set_platdata(pd, sizeof(struct s3c2410_platform_i2c),
-			       &s3c_device_i2c5);
+	npd = s3c_set_platdata(pd, sizeof(*npd), &s3c_device_i2c5);
 
 	if (!npd->cfg_gpio)
 		npd->cfg_gpio = s3c_i2c5_cfg_gpio;
@@ -518,8 +512,7 @@ void __init s3c_i2c6_set_platdata(struct s3c2410_platform_i2c *pd)
 		pd->bus_num = 6;
 	}
 
-	npd = s3c_set_platdata(pd, sizeof(struct s3c2410_platform_i2c),
-			       &s3c_device_i2c6);
+	npd = s3c_set_platdata(pd, sizeof(*npd), &s3c_device_i2c6);
 
 	if (!npd->cfg_gpio)
 		npd->cfg_gpio = s3c_i2c6_cfg_gpio;
@@ -548,8 +541,7 @@ void __init s3c_i2c7_set_platdata(struct s3c2410_platform_i2c *pd)
 		pd->bus_num = 7;
 	}
 
-	npd = s3c_set_platdata(pd, sizeof(struct s3c2410_platform_i2c),
-			       &s3c_device_i2c7);
+	npd = s3c_set_platdata(pd, sizeof(*npd), &s3c_device_i2c7);
 
 	if (!npd->cfg_gpio)
 		npd->cfg_gpio = s3c_i2c7_cfg_gpio;
@@ -615,8 +607,7 @@ void __init samsung_keypad_set_platdata(struct samsung_keypad_platdata *pd)
 {
 	struct samsung_keypad_platdata *npd;
 
-	npd = s3c_set_platdata(pd, sizeof(struct samsung_keypad_platdata),
-			&samsung_device_keypad);
+	npd = s3c_set_platdata(pd, sizeof(*npd), &samsung_device_keypad);
 
 	if (!npd->cfg_gpio)
 		npd->cfg_gpio = samsung_keypad_cfg_gpio;
@@ -721,8 +712,7 @@ void __init s3c_nand_set_platdata(struct s3c2410_platform_nand *nand)
 	 * time then there is little chance the system is going to run.
 	 */
 
-	npd = s3c_set_platdata(nand, sizeof(struct s3c2410_platform_nand),
-				&s3c_device_nand);
+	npd = s3c_set_platdata(nand, sizeof(*npd), &s3c_device_nand);
 	if (!npd)
 		return;
 
@@ -1022,8 +1012,7 @@ void __init dwc2_hsotg_set_platdata(struct dwc2_hsotg_plat *pd)
 {
 	struct dwc2_hsotg_plat *npd;
 
-	npd = s3c_set_platdata(pd, sizeof(struct dwc2_hsotg_plat),
-			&s3c_device_usb_hsotg);
+	npd = s3c_set_platdata(pd, sizeof(*npd), &s3c_device_usb_hsotg);
 
 	if (!npd->phy_init)
 		npd->phy_init = s5p_usb_phy_init;
-- 
2.14.2

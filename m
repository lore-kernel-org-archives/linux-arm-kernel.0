From: joe@perches.com (Joe Perches)
Date: Sat, 13 Sep 2014 11:31:15 -0700
Subject: [PATCH 4/8] arm: mach-imx: Convert pr_warning to pr_warn
In-Reply-To: <cover.1410632834.git.joe@perches.com>
References: <cover.1410632834.git.joe@perches.com>
Message-ID: <2c6cfbc8d456f98db88e20ee3d72a251e929ff0a.1410632835.git.joe@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the more common pr_warn.

Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/arm/mach-imx/mach-armadillo5x0.c | 2 +-
 arch/arm/mach-imx/mach-mx31_3ds.c     | 4 ++--
 arch/arm/mach-imx/mach-mx31lite.c     | 2 +-
 arch/arm/mach-imx/mach-pcm037.c       | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-imx/mach-armadillo5x0.c b/arch/arm/mach-imx/mach-armadillo5x0.c
index a7e9bd2..f206052 100644
--- a/arch/arm/mach-imx/mach-armadillo5x0.c
+++ b/arch/arm/mach-imx/mach-armadillo5x0.c
@@ -537,7 +537,7 @@ static void __init armadillo5x0_init(void)
 			gpio_free(ARMADILLO5X0_RTC_GPIO);
 	}
 	if (armadillo5x0_i2c_rtc.irq == 0)
-		pr_warning("armadillo5x0_init: failed to get RTC IRQ\n");
+		pr_warn("armadillo5x0_init: failed to get RTC IRQ\n");
 	i2c_register_board_info(1, &armadillo5x0_i2c_rtc, 1);
 
 	/* USB */
diff --git a/arch/arm/mach-imx/mach-mx31_3ds.c b/arch/arm/mach-imx/mach-mx31_3ds.c
index 453f41a..65a0dc0 100644
--- a/arch/arm/mach-imx/mach-mx31_3ds.c
+++ b/arch/arm/mach-imx/mach-mx31_3ds.c
@@ -307,7 +307,7 @@ static int mx31_3ds_sdhc1_init(struct device *dev,
 	ret = gpio_request_array(mx31_3ds_sdhc1_gpios,
 				 ARRAY_SIZE(mx31_3ds_sdhc1_gpios));
 	if (ret) {
-		pr_warning("Unable to request the SD/MMC GPIOs.\n");
+		pr_warn("Unable to request the SD/MMC GPIOs.\n");
 		return ret;
 	}
 
@@ -316,7 +316,7 @@ static int mx31_3ds_sdhc1_init(struct device *dev,
 			  IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING,
 			  "sdhc1-detect", data);
 	if (ret) {
-		pr_warning("Unable to request the SD/MMC card-detect IRQ.\n");
+		pr_warn("Unable to request the SD/MMC card-detect IRQ.\n");
 		goto gpio_free;
 	}
 
diff --git a/arch/arm/mach-imx/mach-mx31lite.c b/arch/arm/mach-imx/mach-mx31lite.c
index 57eac6f..4822a17 100644
--- a/arch/arm/mach-imx/mach-mx31lite.c
+++ b/arch/arm/mach-imx/mach-mx31lite.c
@@ -270,7 +270,7 @@ static void __init mx31lite_init(void)
 	/* SMSC9117 IRQ pin */
 	ret = gpio_request(IOMUX_TO_GPIO(MX31_PIN_SFS6), "sms9117-irq");
 	if (ret)
-		pr_warning("could not get LAN irq gpio\n");
+		pr_warn("could not get LAN irq gpio\n");
 	else {
 		gpio_direction_input(IOMUX_TO_GPIO(MX31_PIN_SFS6));
 		smsc911x_resources[1].start =
diff --git a/arch/arm/mach-imx/mach-pcm037.c b/arch/arm/mach-imx/mach-pcm037.c
index 8eb1570..6d87941 100644
--- a/arch/arm/mach-imx/mach-pcm037.c
+++ b/arch/arm/mach-imx/mach-pcm037.c
@@ -58,7 +58,7 @@ static int __init pcm037_variant_setup(char *str)
 	if (!strcmp("eet", str))
 		pcm037_instance = PCM037_EET;
 	else if (strcmp("pcm970", str))
-		pr_warning("Unknown pcm037 baseboard variant %s\n", str);
+		pr_warn("Unknown pcm037 baseboard variant %s\n", str);
 
 	return 1;
 }
@@ -624,7 +624,7 @@ static void __init pcm037_init(void)
 	/* LAN9217 IRQ pin */
 	ret = gpio_request(IOMUX_TO_GPIO(MX31_PIN_GPIO3_1), "lan9217-irq");
 	if (ret)
-		pr_warning("could not get LAN irq gpio\n");
+		pr_warn("could not get LAN irq gpio\n");
 	else {
 		gpio_direction_input(IOMUX_TO_GPIO(MX31_PIN_GPIO3_1));
 		smsc911x_resources[1].start =
-- 
1.8.1.2.459.gbcd45b4.dirty

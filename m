From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 23 Jul 2010 20:56:29 +0900
Subject: [PATCH v3 1/3] ARM: SAMSUNG: Add the member of platdata to implement
	SDMMC Write Protection
In-Reply-To: <1279886191-9197-1-git-send-email-kgene.kim@samsung.com>
References: <1279886191-9197-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1279886191-9197-2-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hyuk Lee <hyuk1.lee@samsung.com>

This patch adds the members of platdata which is wp_gpio.
The wp_gpio is a gpio_number which is connected with WP pin of SD Slot.

Signed-off-by: Hyuk Lee <hyuk1.lee@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/plat-samsung/dev-hsmmc.c          |    1 +
 arch/arm/plat-samsung/dev-hsmmc1.c         |    1 +
 arch/arm/plat-samsung/dev-hsmmc2.c         |    1 +
 arch/arm/plat-samsung/dev-hsmmc3.c         |    1 +
 arch/arm/plat-samsung/include/plat/sdhci.h |    2 ++
 5 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-samsung/dev-hsmmc.c b/arch/arm/plat-samsung/dev-hsmmc.c
index b0f93f1..077d98d 100644
--- a/arch/arm/plat-samsung/dev-hsmmc.c
+++ b/arch/arm/plat-samsung/dev-hsmmc.c
@@ -65,6 +65,7 @@ void s3c_sdhci0_set_platdata(struct s3c_sdhci_platdata *pd)
 	set->ext_cd_cleanup = pd->ext_cd_cleanup;
 	set->ext_cd_gpio = pd->ext_cd_gpio;
 	set->ext_cd_gpio_invert = pd->ext_cd_gpio_invert;
+	set->wp_gpio = pd->wp_gpio;
 
 	if (pd->cfg_gpio)
 		set->cfg_gpio = pd->cfg_gpio;
diff --git a/arch/arm/plat-samsung/dev-hsmmc1.c b/arch/arm/plat-samsung/dev-hsmmc1.c
index 1504fd8..b298514 100644
--- a/arch/arm/plat-samsung/dev-hsmmc1.c
+++ b/arch/arm/plat-samsung/dev-hsmmc1.c
@@ -65,6 +65,7 @@ void s3c_sdhci1_set_platdata(struct s3c_sdhci_platdata *pd)
 	set->ext_cd_cleanup = pd->ext_cd_cleanup;
 	set->ext_cd_gpio = pd->ext_cd_gpio;
 	set->ext_cd_gpio_invert = pd->ext_cd_gpio_invert;
+	set->wp_gpio = pd->wp_gpio;
 
 	if (pd->cfg_gpio)
 		set->cfg_gpio = pd->cfg_gpio;
diff --git a/arch/arm/plat-samsung/dev-hsmmc2.c b/arch/arm/plat-samsung/dev-hsmmc2.c
index b28ef17..d419da7 100644
--- a/arch/arm/plat-samsung/dev-hsmmc2.c
+++ b/arch/arm/plat-samsung/dev-hsmmc2.c
@@ -66,6 +66,7 @@ void s3c_sdhci2_set_platdata(struct s3c_sdhci_platdata *pd)
 	set->ext_cd_cleanup = pd->ext_cd_cleanup;
 	set->ext_cd_gpio = pd->ext_cd_gpio;
 	set->ext_cd_gpio_invert = pd->ext_cd_gpio_invert;
+	set->wp_gpio = pd->wp_gpio;
 
 	if (pd->cfg_gpio)
 		set->cfg_gpio = pd->cfg_gpio;
diff --git a/arch/arm/plat-samsung/dev-hsmmc3.c b/arch/arm/plat-samsung/dev-hsmmc3.c
index 85aaf0f..658456d 100644
--- a/arch/arm/plat-samsung/dev-hsmmc3.c
+++ b/arch/arm/plat-samsung/dev-hsmmc3.c
@@ -69,6 +69,7 @@ void s3c_sdhci3_set_platdata(struct s3c_sdhci_platdata *pd)
 	set->ext_cd_cleanup = pd->ext_cd_cleanup;
 	set->ext_cd_gpio = pd->ext_cd_gpio;
 	set->ext_cd_gpio_invert = pd->ext_cd_gpio_invert;
+	set->wp_gpio = pd->wp_gpio;
 
 	if (pd->cfg_gpio)
 		set->cfg_gpio = pd->cfg_gpio;
diff --git a/arch/arm/plat-samsung/include/plat/sdhci.h b/arch/arm/plat-samsung/include/plat/sdhci.h
index 7c21a7c..1ad698f 100644
--- a/arch/arm/plat-samsung/include/plat/sdhci.h
+++ b/arch/arm/plat-samsung/include/plat/sdhci.h
@@ -33,6 +33,7 @@ enum cd_types {
  * @max_width: The maximum number of data bits supported.
  * @host_caps: Standard MMC host capabilities bit field.
  * @cd_type: Type of Card Detection method (see cd_types enum above)
+ * @wp_gpio: The gpio number using for WP.
  * @ext_cd_init: Initialize external card detect subsystem. Called on
  *		 sdhci-s3c driver probe when cd_type == S3C_SDHCI_CD_EXTERNAL.
  *		 notify_func argument is a callback to the sdhci-s3c driver
@@ -62,6 +63,7 @@ struct s3c_sdhci_platdata {
 
 	char		**clocks;	/* set of clock sources */
 
+	int		wp_gpio;
 	int		ext_cd_gpio;
 	bool		ext_cd_gpio_invert;
 	int	(*ext_cd_init)(void (*notify_func)(struct platform_device *,
-- 
1.6.2.5

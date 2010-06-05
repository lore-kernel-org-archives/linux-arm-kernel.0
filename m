From: kmpark@infradead.org (Kyungmin Park)
Date: Sat, 05 Jun 2010 11:40:53 +0900
Subject: [PATCH] s5pc110: SDHCI-s3c can override host capabilities
Message-ID: <20100605024053.GA23419@july>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Each board can override the default sdhci host capabilities.
Some board has broken features by hardwares and support 8-bit bandwidth.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
diff --git a/arch/arm/plat-samsung/dev-hsmmc.c b/arch/arm/plat-samsung/dev-hsmmc.c
index 4c05b39..d0887da 100644
--- a/arch/arm/plat-samsung/dev-hsmmc.c
+++ b/arch/arm/plat-samsung/dev-hsmmc.c
@@ -65,4 +65,6 @@ void s3c_sdhci0_set_platdata(struct s3c_sdhci_platdata *pd)
 		set->cfg_gpio = pd->cfg_gpio;
 	if (pd->cfg_card)
 		set->cfg_card = pd->cfg_card;
+	if (pd->host_caps)
+		set->host_caps = pd->host_caps;
 }
diff --git a/arch/arm/plat-samsung/dev-hsmmc1.c b/arch/arm/plat-samsung/dev-hsmmc1.c
index e49bc4c..e45a82e 100644
--- a/arch/arm/plat-samsung/dev-hsmmc1.c
+++ b/arch/arm/plat-samsung/dev-hsmmc1.c
@@ -65,4 +65,6 @@ void s3c_sdhci1_set_platdata(struct s3c_sdhci_platdata *pd)
 		set->cfg_gpio = pd->cfg_gpio;
 	if (pd->cfg_card)
 		set->cfg_card = pd->cfg_card;
+	if (pd->host_caps)
+		set->host_caps = pd->host_caps;
 }
diff --git a/arch/arm/plat-samsung/dev-hsmmc2.c b/arch/arm/plat-samsung/dev-hsmmc2.c
index 824580b..5ee3b89 100644
--- a/arch/arm/plat-samsung/dev-hsmmc2.c
+++ b/arch/arm/plat-samsung/dev-hsmmc2.c
@@ -66,4 +66,6 @@ void s3c_sdhci2_set_platdata(struct s3c_sdhci_platdata *pd)
 		set->cfg_gpio = pd->cfg_gpio;
 	if (pd->cfg_card)
 		set->cfg_card = pd->cfg_card;
+	if (pd->host_caps)
+		set->host_caps = pd->host_caps;
 }

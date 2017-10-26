From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Thu, 26 Oct 2017 20:50:28 +0800
Subject: [PATCH 3/3] phy: phy-mtk-tphy: fix alignment warning
In-Reply-To: <f08880e993f05761f0171b83812e940d30a54b05.1509022149.git.chunfeng.yun@mediatek.com>
References: <f08880e993f05761f0171b83812e940d30a54b05.1509022149.git.chunfeng.yun@mediatek.com>
Message-ID: <964f480553791aab43299a8ac06cc44a9430eea2.1509022150.git.chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix alignment warning by checkpatch.pl with --strict

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/phy/mediatek/Kconfig        |    8 ++++----
 drivers/phy/mediatek/phy-mtk-tphy.c |   24 ++++++++++++------------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/phy/mediatek/Kconfig b/drivers/phy/mediatek/Kconfig
index 88ab4e2..fb4bcd9 100644
--- a/drivers/phy/mediatek/Kconfig
+++ b/drivers/phy/mediatek/Kconfig
@@ -8,7 +8,7 @@ config PHY_MTK_TPHY
     help
       Say 'Y' here to add support for MediaTek T-PHY driver,
       it supports multiple usb2.0, usb3.0 ports, PCIe and
-	  SATA, and meanwhile supports two version T-PHY which have
-	  different banks layout, the T-PHY with shared banks between
-	  multi-ports is first version, otherwise is second veriosn,
-	  so you can easily distinguish them by banks layout.
+      SATA, and meanwhile supports two version T-PHY which have
+      different banks layout, the T-PHY with shared banks between
+      multi-ports is first version, otherwise is second veriosn,
+      so you can easily distinguish them by banks layout.
diff --git a/drivers/phy/mediatek/phy-mtk-tphy.c b/drivers/phy/mediatek/phy-mtk-tphy.c
index cdd33bf..02b00b7 100644
--- a/drivers/phy/mediatek/phy-mtk-tphy.c
+++ b/drivers/phy/mediatek/phy-mtk-tphy.c
@@ -309,7 +309,7 @@ struct mtk_tphy {
 };
 
 static void hs_slew_rate_calibrate(struct mtk_tphy *tphy,
-	struct mtk_phy_instance *instance)
+				   struct mtk_phy_instance *instance)
 {
 	struct u2phy_banks *u2_banks = &instance->u2_banks;
 	void __iomem *fmreg = u2_banks->fmreg;
@@ -384,7 +384,7 @@ static void hs_slew_rate_calibrate(struct mtk_tphy *tphy,
 }
 
 static void u3_phy_instance_init(struct mtk_tphy *tphy,
-	struct mtk_phy_instance *instance)
+				 struct mtk_phy_instance *instance)
 {
 	struct u3phy_banks *u3_banks = &instance->u3_banks;
 	u32 tmp;
@@ -434,7 +434,7 @@ static void u3_phy_instance_init(struct mtk_tphy *tphy,
 }
 
 static void u2_phy_instance_init(struct mtk_tphy *tphy,
-	struct mtk_phy_instance *instance)
+				 struct mtk_phy_instance *instance)
 {
 	struct u2phy_banks *u2_banks = &instance->u2_banks;
 	void __iomem *com = u2_banks->com;
@@ -496,7 +496,7 @@ static void u2_phy_instance_init(struct mtk_tphy *tphy,
 }
 
 static void u2_phy_instance_power_on(struct mtk_tphy *tphy,
-	struct mtk_phy_instance *instance)
+				     struct mtk_phy_instance *instance)
 {
 	struct u2phy_banks *u2_banks = &instance->u2_banks;
 	void __iomem *com = u2_banks->com;
@@ -530,7 +530,7 @@ static void u2_phy_instance_power_on(struct mtk_tphy *tphy,
 }
 
 static void u2_phy_instance_power_off(struct mtk_tphy *tphy,
-	struct mtk_phy_instance *instance)
+				      struct mtk_phy_instance *instance)
 {
 	struct u2phy_banks *u2_banks = &instance->u2_banks;
 	void __iomem *com = u2_banks->com;
@@ -565,7 +565,7 @@ static void u2_phy_instance_power_off(struct mtk_tphy *tphy,
 }
 
 static void u2_phy_instance_exit(struct mtk_tphy *tphy,
-	struct mtk_phy_instance *instance)
+				 struct mtk_phy_instance *instance)
 {
 	struct u2phy_banks *u2_banks = &instance->u2_banks;
 	void __iomem *com = u2_banks->com;
@@ -609,7 +609,7 @@ static void u2_phy_instance_set_mode(struct mtk_tphy *tphy,
 }
 
 static void pcie_phy_instance_init(struct mtk_tphy *tphy,
-	struct mtk_phy_instance *instance)
+				   struct mtk_phy_instance *instance)
 {
 	struct u3phy_banks *u3_banks = &instance->u3_banks;
 	u32 tmp;
@@ -682,7 +682,7 @@ static void pcie_phy_instance_init(struct mtk_tphy *tphy,
 }
 
 static void pcie_phy_instance_power_on(struct mtk_tphy *tphy,
-	struct mtk_phy_instance *instance)
+				       struct mtk_phy_instance *instance)
 {
 	struct u3phy_banks *bank = &instance->u3_banks;
 	u32 tmp;
@@ -698,7 +698,7 @@ static void pcie_phy_instance_power_on(struct mtk_tphy *tphy,
 }
 
 static void pcie_phy_instance_power_off(struct mtk_tphy *tphy,
-	struct mtk_phy_instance *instance)
+					struct mtk_phy_instance *instance)
 
 {
 	struct u3phy_banks *bank = &instance->u3_banks;
@@ -714,7 +714,7 @@ static void pcie_phy_instance_power_off(struct mtk_tphy *tphy,
 }
 
 static void sata_phy_instance_init(struct mtk_tphy *tphy,
-	struct mtk_phy_instance *instance)
+				   struct mtk_phy_instance *instance)
 {
 	struct u3phy_banks *u3_banks = &instance->u3_banks;
 	void __iomem *phyd = u3_banks->phyd;
@@ -916,7 +916,7 @@ static int mtk_phy_set_mode(struct phy *phy, enum phy_mode mode)
 }
 
 static struct phy *mtk_phy_xlate(struct device *dev,
-					struct of_phandle_args *args)
+				 struct of_phandle_args *args)
 {
 	struct mtk_tphy *tphy = dev_get_drvdata(dev);
 	struct mtk_phy_instance *instance = NULL;
@@ -1015,7 +1015,7 @@ static int mtk_tphy_probe(struct platform_device *pdev)
 
 	tphy->nphys = of_get_child_count(np);
 	tphy->phys = devm_kcalloc(dev, tphy->nphys,
-				       sizeof(*tphy->phys), GFP_KERNEL);
+				  sizeof(*tphy->phys), GFP_KERNEL);
 	if (!tphy->phys)
 		return -ENOMEM;
 
-- 
1.7.9.5

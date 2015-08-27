From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Thu, 27 Aug 2015 13:52:02 +0200
Subject: [PATCH] rtc: Fix module autoload for OF platform drivers
Message-ID: <1440676322-19870-1-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These platform drivers have a OF device ID table but the OF module
alias information is not created so module autoloading won't work.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

 drivers/rtc/rtc-armada38x.c | 1 +
 drivers/rtc/rtc-coh901331.c | 1 +
 drivers/rtc/rtc-da9063.c    | 1 +
 drivers/rtc/rtc-moxart.c    | 1 +
 drivers/rtc/rtc-mpc5121.c   | 1 +
 drivers/rtc/rtc-mt6397.c    | 1 +
 drivers/rtc/rtc-mv.c        | 1 +
 drivers/rtc/rtc-vt8500.c    | 1 +
 8 files changed, 8 insertions(+)

diff --git a/drivers/rtc/rtc-armada38x.c b/drivers/rtc/rtc-armada38x.c
index 06c6bd5eab41..9a3f2a6f512e 100644
--- a/drivers/rtc/rtc-armada38x.c
+++ b/drivers/rtc/rtc-armada38x.c
@@ -295,6 +295,7 @@ static const struct of_device_id armada38x_rtc_of_match_table[] = {
 	{ .compatible = "marvell,armada-380-rtc", },
 	{}
 };
+MODULE_DEVICE_TABLE(of, armada38x_rtc_of_match_table);
 #endif
 
 static struct platform_driver armada38x_rtc_driver = {
diff --git a/drivers/rtc/rtc-coh901331.c b/drivers/rtc/rtc-coh901331.c
index 56343b2fbc68..101b7a240e0f 100644
--- a/drivers/rtc/rtc-coh901331.c
+++ b/drivers/rtc/rtc-coh901331.c
@@ -263,6 +263,7 @@ static const struct of_device_id coh901331_dt_match[] = {
 	{ .compatible = "stericsson,coh901331" },
 	{},
 };
+MODULE_DEVICE_TABLE(of, coh901331_dt_match);
 
 static struct platform_driver coh901331_driver = {
 	.driver = {
diff --git a/drivers/rtc/rtc-da9063.c b/drivers/rtc/rtc-da9063.c
index 5f38a5c84b56..00a8f7f4f87c 100644
--- a/drivers/rtc/rtc-da9063.c
+++ b/drivers/rtc/rtc-da9063.c
@@ -169,6 +169,7 @@ static const struct of_device_id da9063_compatible_reg_id_table[] = {
 	{ .compatible = "dlg,da9062-rtc", .data = &da9062_aa_regs },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, da9063_compatible_reg_id_table);
 
 static void da9063_data_to_tm(u8 *data, struct rtc_time *tm,
 			      struct da9063_compatible_rtc *rtc)
diff --git a/drivers/rtc/rtc-moxart.c b/drivers/rtc/rtc-moxart.c
index 73759c9a4527..07b30a373a92 100644
--- a/drivers/rtc/rtc-moxart.c
+++ b/drivers/rtc/rtc-moxart.c
@@ -312,6 +312,7 @@ static const struct of_device_id moxart_rtc_match[] = {
 	{ .compatible = "moxa,moxart-rtc" },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, moxart_rtc_match);
 
 static struct platform_driver moxart_rtc_driver = {
 	.probe	= moxart_rtc_probe,
diff --git a/drivers/rtc/rtc-mpc5121.c b/drivers/rtc/rtc-mpc5121.c
index 1767e18d5bd4..4ca4daa0b8f3 100644
--- a/drivers/rtc/rtc-mpc5121.c
+++ b/drivers/rtc/rtc-mpc5121.c
@@ -406,6 +406,7 @@ static const struct of_device_id mpc5121_rtc_match[] = {
 	{ .compatible = "fsl,mpc5200-rtc", },
 	{},
 };
+MODULE_DEVICE_TABLE(of, mpc5121_rtc_match);
 #endif
 
 static struct platform_driver mpc5121_rtc_driver = {
diff --git a/drivers/rtc/rtc-mt6397.c b/drivers/rtc/rtc-mt6397.c
index 30c926b36361..06a5c52b292f 100644
--- a/drivers/rtc/rtc-mt6397.c
+++ b/drivers/rtc/rtc-mt6397.c
@@ -402,6 +402,7 @@ static const struct of_device_id mt6397_rtc_of_match[] = {
 	{ .compatible = "mediatek,mt6397-rtc", },
 	{ }
 };
+MODULE_DEVICE_TABLE(of, mt6397_rtc_of_match);
 
 static struct platform_driver mtk_rtc_driver = {
 	.driver = {
diff --git a/drivers/rtc/rtc-mv.c b/drivers/rtc/rtc-mv.c
index 7f50d2ef7f6e..79bb28617d45 100644
--- a/drivers/rtc/rtc-mv.c
+++ b/drivers/rtc/rtc-mv.c
@@ -324,6 +324,7 @@ static const struct of_device_id rtc_mv_of_match_table[] = {
 	{ .compatible = "marvell,orion-rtc", },
 	{}
 };
+MODULE_DEVICE_TABLE(of, rtc_mv_of_match_table);
 #endif
 
 static struct platform_driver mv_rtc_driver = {
diff --git a/drivers/rtc/rtc-vt8500.c b/drivers/rtc/rtc-vt8500.c
index a58b6d17e6f0..27e896995e9b 100644
--- a/drivers/rtc/rtc-vt8500.c
+++ b/drivers/rtc/rtc-vt8500.c
@@ -271,6 +271,7 @@ static const struct of_device_id wmt_dt_ids[] = {
 	{ .compatible = "via,vt8500-rtc", },
 	{}
 };
+MODULE_DEVICE_TABLE(of, wmt_dt_ids);
 
 static struct platform_driver vt8500_rtc_driver = {
 	.probe		= vt8500_rtc_probe,
-- 
2.4.3

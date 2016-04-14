From: jamesjj.liao@mediatek.com (James Liao)
Date: Thu, 14 Apr 2016 16:11:53 +0800
Subject: [PATCH v7 8/9] clk: mediatek: Add config options for MT2701 subsystem
 clocks
In-Reply-To: <1460621514-65191-1-git-send-email-jamesjj.liao@mediatek.com>
References: <1460621514-65191-1-git-send-email-jamesjj.liao@mediatek.com>
Message-ID: <1460621514-65191-9-git-send-email-jamesjj.liao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MT2701 subsystem clocks are optional and should be enabled only if
their subsystem drivers are ready to control these clocks.

Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
---
 drivers/clk/mediatek/Kconfig      | 44 ++++++++++++++++++++++++++++++++++++++-
 drivers/clk/mediatek/clk-mt2701.c | 36 ++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index 1e56000..5aa6204 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -12,7 +12,49 @@ config COMMON_CLK_MT2701
 	select COMMON_CLK_MEDIATEK
 	default ARCH_MEDIATEK
 	---help---
-	  This driver supports Mediatek MT2701 clocks.
+	  This driver supports Mediatek MT2701 basic clocks.
+
+config COMMON_CLK_MT2701_MMSYS
+	bool "Clock driver for Mediatek MT2701 mmsys"
+	depends on COMMON_CLK
+	select COMMON_CLK_MT2701
+	---help---
+	  This driver supports Mediatek MT2701 mmsys clocks.
+
+config COMMON_CLK_MT2701_IMGSYS
+	bool "Clock driver for Mediatek MT2701 imgsys"
+	depends on COMMON_CLK
+	select COMMON_CLK_MT2701
+	---help---
+	  This driver supports Mediatek MT2701 imgsys clocks.
+
+config COMMON_CLK_MT2701_VDECSYS
+	bool "Clock driver for Mediatek MT2701 vdecsys"
+	depends on COMMON_CLK
+	select COMMON_CLK_MT2701
+	---help---
+	  This driver supports Mediatek MT2701 vdecsys clocks.
+
+config COMMON_CLK_MT2701_HIFSYS
+	bool "Clock driver for Mediatek MT2701 hifsys"
+	depends on COMMON_CLK
+	select COMMON_CLK_MT2701
+	---help---
+	  This driver supports Mediatek MT2701 hifsys clocks.
+
+config COMMON_CLK_MT2701_ETHSYS
+	bool "Clock driver for Mediatek MT2701 ethsys"
+	depends on COMMON_CLK
+	select COMMON_CLK_MT2701
+	---help---
+	  This driver supports Mediatek MT2701 ethsys clocks.
+
+config COMMON_CLK_MT2701_BDPSYS
+	bool "Clock driver for Mediatek MT2701 bdpsys"
+	depends on COMMON_CLK
+	select COMMON_CLK_MT2701
+	---help---
+	  This driver supports Mediatek MT2701 bdpsys clocks.
 
 config COMMON_CLK_MT8135
 	bool "Clock driver for Mediatek MT8135"
diff --git a/drivers/clk/mediatek/clk-mt2701.c b/drivers/clk/mediatek/clk-mt2701.c
index 90294e7..68869ff 100644
--- a/drivers/clk/mediatek/clk-mt2701.c
+++ b/drivers/clk/mediatek/clk-mt2701.c
@@ -908,6 +908,8 @@ static void __init mtk_pericfg_init(struct device_node *node)
 }
 CLK_OF_DECLARE(mtk_pericfg, "mediatek,mt2701-pericfg", mtk_pericfg_init);
 
+#ifdef CONFIG_COMMON_CLK_MT2701_MMSYS
+
 static const struct mtk_gate_regs disp0_cg_regs __initconst = {
 	.set_ofs = 0x0104,
 	.clr_ofs = 0x0108,
@@ -991,6 +993,10 @@ static void __init mtk_mmsys_init(struct device_node *node)
 			__func__, r);
 }
 
+#endif /* CONFIG_COMMON_CLK_MT2701_MMSYS */
+
+#ifdef CONFIG_COMMON_CLK_MT2701_IMGSYS
+
 static const struct mtk_gate_regs img_cg_regs __initconst = {
 	.set_ofs = 0x0004,
 	.clr_ofs = 0x0008,
@@ -1031,6 +1037,10 @@ static void __init mtk_imgsys_init(struct device_node *node)
 			__func__, r);
 }
 
+#endif /* CONFIG_COMMON_CLK_MT2701_IMGSYS */
+
+#ifdef CONFIG_COMMON_CLK_MT2701_VDECSYS
+
 static const struct mtk_gate_regs vdec0_cg_regs __initconst = {
 	.set_ofs = 0x0000,
 	.clr_ofs = 0x0004,
@@ -1082,6 +1092,10 @@ static void __init mtk_vdecsys_init(struct device_node *node)
 			__func__, r);
 }
 
+#endif /* CONFIG_COMMON_CLK_MT2701_VDECSYS */
+
+#ifdef CONFIG_COMMON_CLK_MT2701_HIFSYS
+
 static const struct mtk_gate_regs hif_cg_regs __initconst = {
 	.sta_ofs = 0x0008,
 };
@@ -1121,6 +1135,10 @@ static void __init mtk_hifsys_init(struct device_node *node)
 	mtk_register_reset_controller(node, 1, 0x34);
 }
 
+#endif /* CONFIG_COMMON_CLK_MT2701_HIFSYS */
+
+#ifdef CONFIG_COMMON_CLK_MT2701_ETHSYS
+
 static const struct mtk_gate_regs eth_cg_regs __initconst = {
 	.sta_ofs = 0x0030,
 };
@@ -1161,6 +1179,10 @@ static void __init mtk_ethsys_init(struct device_node *node)
 			__func__, r);
 }
 
+#endif /* CONFIG_COMMON_CLK_MT2701_ETHSYS */
+
+#ifdef CONFIG_COMMON_CLK_MT2701_BDPSYS
+
 static const struct mtk_gate_regs bdp0_cg_regs __initconst = {
 	.set_ofs = 0x0104,
 	.clr_ofs = 0x0108,
@@ -1259,6 +1281,8 @@ static void __init mtk_bdpsys_init(struct device_node *node)
 			__func__, r);
 }
 
+#endif /* CONFIG_COMMON_CLK_MT2701_BDPSYS */
+
 #define MT8590_PLL_FMAX		(2000 * MHZ)
 #define CON0_MT8590_RST_BAR	BIT(27)
 
@@ -1333,24 +1357,36 @@ CLK_OF_DECLARE(mtk_apmixedsys, "mediatek,mt2701-apmixedsys",
 
 static const struct of_device_id of_clk_match_tbl[] = {
 	{
+#ifdef CONFIG_COMMON_CLK_MT2701_MMSYS
 		.compatible = "mediatek,mt2701-mmsys",
 		.data = mtk_mmsys_init,
 	}, {
+#endif
+#ifdef CONFIG_COMMON_CLK_MT2701_IMGSYS
 		.compatible = "mediatek,mt2701-imgsys",
 		.data = mtk_imgsys_init,
 	}, {
+#endif
+#ifdef CONFIG_COMMON_CLK_MT2701_VDECSYS
 		.compatible = "mediatek,mt2701-vdecsys",
 		.data = mtk_vdecsys_init,
 	}, {
+#endif
+#ifdef CONFIG_COMMON_CLK_MT2701_HIFSYS
 		.compatible = "mediatek,mt2701-hifsys",
 		.data = mtk_hifsys_init,
 	}, {
+#endif
+#ifdef CONFIG_COMMON_CLK_MT2701_ETHSYS
 		.compatible = "mediatek,mt2701-ethsys",
 		.data = mtk_ethsys_init,
 	}, {
+#endif
+#ifdef CONFIG_COMMON_CLK_MT2701_BDPSYS
 		.compatible = "mediatek,mt2701-bdpsys",
 		.data = mtk_bdpsys_init,
 	}, {
+#endif
 		/* sentinel */
 	}
 };
-- 
1.9.1

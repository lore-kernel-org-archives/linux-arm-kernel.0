From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 31 May 2016 17:05:08 +0900
Subject: [PATCH 02/17] pinctrl: uniphier: rename function and variable names
In-Reply-To: <1464681923-7469-1-git-send-email-yamada.masahiro@socionext.com>
References: <1464681923-7469-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1464681923-7469-3-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make function/variable names match the file names for consistency.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/pinctrl/uniphier/pinctrl-uniphier-ld4.c  | 42 ++++++++++++------------
 drivers/pinctrl/uniphier/pinctrl-uniphier-ld6b.c | 42 ++++++++++++------------
 drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c | 42 ++++++++++++------------
 drivers/pinctrl/uniphier/pinctrl-uniphier-pro5.c | 42 ++++++++++++------------
 drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c | 42 ++++++++++++------------
 drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c | 42 ++++++++++++------------
 6 files changed, 126 insertions(+), 126 deletions(-)

diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld4.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld4.c
index 4a0439c..fdcdc91 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld4.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld4.c
@@ -19,9 +19,9 @@
 
 #include "pinctrl-uniphier.h"
 
-#define DRIVER_NAME "ph1-ld4-pinctrl"
+#define DRIVER_NAME "uniphier-ld4-pinctrl"
 
-static const struct pinctrl_pin_desc ph1_ld4_pins[] = {
+static const struct pinctrl_pin_desc uniphier_ld4_pins[] = {
 	UNIPHIER_PINCTRL_PIN(0, "EA1", UNIPHIER_PIN_IECTRL_NONE,
 			     8, UNIPHIER_PIN_DRV_4_8,
 			     8, UNIPHIER_PIN_PULL_DOWN),
@@ -612,7 +612,7 @@ static const unsigned xirq_range1_muxvals[] = {
 	0, 14,						/* XIRQ14-15 */
 };
 
-static const struct uniphier_pinctrl_group ph1_ld4_groups[] = {
+static const struct uniphier_pinctrl_group uniphier_ld4_groups[] = {
 	UNIPHIER_PINCTRL_GROUP(emmc),
 	UNIPHIER_PINCTRL_GROUP(emmc_dat8),
 	UNIPHIER_PINCTRL_GROUP(i2c0),
@@ -828,7 +828,7 @@ static const char * const xirq_groups[] = {
 	"xirq12", /* none*/ "xirq14", "xirq15",
 };
 
-static const struct uniphier_pinmux_function ph1_ld4_functions[] = {
+static const struct uniphier_pinmux_function uniphier_ld4_functions[] = {
 	UNIPHIER_PINMUX_FUNCTION(emmc),
 	UNIPHIER_PINMUX_FUNCTION(i2c0),
 	UNIPHIER_PINMUX_FUNCTION(i2c1),
@@ -847,43 +847,43 @@ static const struct uniphier_pinmux_function ph1_ld4_functions[] = {
 	UNIPHIER_PINMUX_FUNCTION(xirq),
 };
 
-static struct uniphier_pinctrl_socdata ph1_ld4_pindata = {
-	.groups = ph1_ld4_groups,
-	.groups_count = ARRAY_SIZE(ph1_ld4_groups),
-	.functions = ph1_ld4_functions,
-	.functions_count = ARRAY_SIZE(ph1_ld4_functions),
+static struct uniphier_pinctrl_socdata uniphier_ld4_pindata = {
+	.groups = uniphier_ld4_groups,
+	.groups_count = ARRAY_SIZE(uniphier_ld4_groups),
+	.functions = uniphier_ld4_functions,
+	.functions_count = ARRAY_SIZE(uniphier_ld4_functions),
 	.mux_bits = 8,
 	.reg_stride = 4,
 	.load_pinctrl = false,
 };
 
-static struct pinctrl_desc ph1_ld4_pinctrl_desc = {
+static struct pinctrl_desc uniphier_ld4_pinctrl_desc = {
 	.name = DRIVER_NAME,
-	.pins = ph1_ld4_pins,
-	.npins = ARRAY_SIZE(ph1_ld4_pins),
+	.pins = uniphier_ld4_pins,
+	.npins = ARRAY_SIZE(uniphier_ld4_pins),
 	.owner = THIS_MODULE,
 };
 
-static int ph1_ld4_pinctrl_probe(struct platform_device *pdev)
+static int uniphier_ld4_pinctrl_probe(struct platform_device *pdev)
 {
-	return uniphier_pinctrl_probe(pdev, &ph1_ld4_pinctrl_desc,
-				      &ph1_ld4_pindata);
+	return uniphier_pinctrl_probe(pdev, &uniphier_ld4_pinctrl_desc,
+				      &uniphier_ld4_pindata);
 }
 
-static const struct of_device_id ph1_ld4_pinctrl_match[] = {
+static const struct of_device_id uniphier_ld4_pinctrl_match[] = {
 	{ .compatible = "socionext,ph1-ld4-pinctrl" },
 	{ /* sentinel */ }
 };
-MODULE_DEVICE_TABLE(of, ph1_ld4_pinctrl_match);
+MODULE_DEVICE_TABLE(of, uniphier_ld4_pinctrl_match);
 
-static struct platform_driver ph1_ld4_pinctrl_driver = {
-	.probe = ph1_ld4_pinctrl_probe,
+static struct platform_driver uniphier_ld4_pinctrl_driver = {
+	.probe = uniphier_ld4_pinctrl_probe,
 	.driver = {
 		.name = DRIVER_NAME,
-		.of_match_table = ph1_ld4_pinctrl_match,
+		.of_match_table = uniphier_ld4_pinctrl_match,
 	},
 };
-module_platform_driver(ph1_ld4_pinctrl_driver);
+module_platform_driver(uniphier_ld4_pinctrl_driver);
 
 MODULE_AUTHOR("Masahiro Yamada <yamada.masahiro@socionext.com>");
 MODULE_DESCRIPTION("UniPhier PH1-LD4 pinctrl driver");
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld6b.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld6b.c
index 150d339..99a3e1a 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld6b.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld6b.c
@@ -19,9 +19,9 @@
 
 #include "pinctrl-uniphier.h"
 
-#define DRIVER_NAME "ph1-ld6b-pinctrl"
+#define DRIVER_NAME "uniphier-ld6b-pinctrl"
 
-static const struct pinctrl_pin_desc ph1_ld6b_pins[] = {
+static const struct pinctrl_pin_desc uniphier_ld6b_pins[] = {
 	UNIPHIER_PINCTRL_PIN(0, "ED0", UNIPHIER_PIN_IECTRL_NONE,
 			     0, UNIPHIER_PIN_DRV_4_8,
 			     0, UNIPHIER_PIN_PULL_DOWN),
@@ -858,7 +858,7 @@ static const unsigned xirq_muxvals[] = {
 	14, 14, 14, 14, 14, 14, 14, 14,			/* XIRQ16-23 */
 };
 
-static const struct uniphier_pinctrl_group ph1_ld6b_groups[] = {
+static const struct uniphier_pinctrl_group uniphier_ld6b_groups[] = {
 	UNIPHIER_PINCTRL_GROUP(adinter),
 	UNIPHIER_PINCTRL_GROUP(emmc),
 	UNIPHIER_PINCTRL_GROUP(emmc_dat8),
@@ -1215,7 +1215,7 @@ static const char * const xirq_groups[] = {
 	"xirq20", "xirq21", "xirq22", "xirq23",
 };
 
-static const struct uniphier_pinmux_function ph1_ld6b_functions[] = {
+static const struct uniphier_pinmux_function uniphier_ld6b_functions[] = {
 	UNIPHIER_PINMUX_FUNCTION(adinter), /* Achip-Dchip interconnect */
 	UNIPHIER_PINMUX_FUNCTION(emmc),
 	UNIPHIER_PINMUX_FUNCTION(i2c0),
@@ -1235,43 +1235,43 @@ static const struct uniphier_pinmux_function ph1_ld6b_functions[] = {
 	UNIPHIER_PINMUX_FUNCTION(xirq),
 };
 
-static struct uniphier_pinctrl_socdata ph1_ld6b_pindata = {
-	.groups = ph1_ld6b_groups,
-	.groups_count = ARRAY_SIZE(ph1_ld6b_groups),
-	.functions = ph1_ld6b_functions,
-	.functions_count = ARRAY_SIZE(ph1_ld6b_functions),
+static struct uniphier_pinctrl_socdata uniphier_ld6b_pindata = {
+	.groups = uniphier_ld6b_groups,
+	.groups_count = ARRAY_SIZE(uniphier_ld6b_groups),
+	.functions = uniphier_ld6b_functions,
+	.functions_count = ARRAY_SIZE(uniphier_ld6b_functions),
 	.mux_bits = 8,
 	.reg_stride = 4,
 	.load_pinctrl = false,
 };
 
-static struct pinctrl_desc ph1_ld6b_pinctrl_desc = {
+static struct pinctrl_desc uniphier_ld6b_pinctrl_desc = {
 	.name = DRIVER_NAME,
-	.pins = ph1_ld6b_pins,
-	.npins = ARRAY_SIZE(ph1_ld6b_pins),
+	.pins = uniphier_ld6b_pins,
+	.npins = ARRAY_SIZE(uniphier_ld6b_pins),
 	.owner = THIS_MODULE,
 };
 
-static int ph1_ld6b_pinctrl_probe(struct platform_device *pdev)
+static int uniphier_ld6b_pinctrl_probe(struct platform_device *pdev)
 {
-	return uniphier_pinctrl_probe(pdev, &ph1_ld6b_pinctrl_desc,
-				      &ph1_ld6b_pindata);
+	return uniphier_pinctrl_probe(pdev, &uniphier_ld6b_pinctrl_desc,
+				      &uniphier_ld6b_pindata);
 }
 
-static const struct of_device_id ph1_ld6b_pinctrl_match[] = {
+static const struct of_device_id uniphier_ld6b_pinctrl_match[] = {
 	{ .compatible = "socionext,ph1-ld6b-pinctrl" },
 	{ /* sentinel */ }
 };
-MODULE_DEVICE_TABLE(of, ph1_ld6b_pinctrl_match);
+MODULE_DEVICE_TABLE(of, uniphier_ld6b_pinctrl_match);
 
-static struct platform_driver ph1_ld6b_pinctrl_driver = {
-	.probe = ph1_ld6b_pinctrl_probe,
+static struct platform_driver uniphier_ld6b_pinctrl_driver = {
+	.probe = uniphier_ld6b_pinctrl_probe,
 	.driver = {
 		.name = DRIVER_NAME,
-		.of_match_table = ph1_ld6b_pinctrl_match,
+		.of_match_table = uniphier_ld6b_pinctrl_match,
 	},
 };
-module_platform_driver(ph1_ld6b_pinctrl_driver);
+module_platform_driver(uniphier_ld6b_pinctrl_driver);
 
 MODULE_AUTHOR("Masahiro Yamada <yamada.masahiro@socionext.com>");
 MODULE_DESCRIPTION("UniPhier PH1-LD6b pinctrl driver");
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c
index b1f09e6..2d45307 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c
@@ -19,9 +19,9 @@
 
 #include "pinctrl-uniphier.h"
 
-#define DRIVER_NAME "ph1-pro4-pinctrl"
+#define DRIVER_NAME "uniphier-pro4-pinctrl"
 
-static const struct pinctrl_pin_desc ph1_pro4_pins[] = {
+static const struct pinctrl_pin_desc uniphier_pro4_pins[] = {
 	UNIPHIER_PINCTRL_PIN(0, "CK24O", UNIPHIER_PIN_IECTRL_NONE,
 			     0, UNIPHIER_PIN_DRV_4_8,
 			     0, UNIPHIER_PIN_PULL_DOWN),
@@ -1135,7 +1135,7 @@ static const unsigned xirq_alternatives_muxvals[] = {
 	2, 2, 2,
 };
 
-static const struct uniphier_pinctrl_group ph1_pro4_groups[] = {
+static const struct uniphier_pinctrl_group uniphier_pro4_groups[] = {
 	UNIPHIER_PINCTRL_GROUP(emmc),
 	UNIPHIER_PINCTRL_GROUP(emmc_dat8),
 	UNIPHIER_PINCTRL_GROUP(i2c0),
@@ -1499,7 +1499,7 @@ static const char * const xirq_groups[] = {
 	"xirq14b", "xirq17b", "xirq18b",
 };
 
-static const struct uniphier_pinmux_function ph1_pro4_functions[] = {
+static const struct uniphier_pinmux_function uniphier_pro4_functions[] = {
 	UNIPHIER_PINMUX_FUNCTION(emmc),
 	UNIPHIER_PINMUX_FUNCTION(i2c0),
 	UNIPHIER_PINMUX_FUNCTION(i2c1),
@@ -1521,43 +1521,43 @@ static const struct uniphier_pinmux_function ph1_pro4_functions[] = {
 	UNIPHIER_PINMUX_FUNCTION(xirq),
 };
 
-static struct uniphier_pinctrl_socdata ph1_pro4_pindata = {
-	.groups = ph1_pro4_groups,
-	.groups_count = ARRAY_SIZE(ph1_pro4_groups),
-	.functions = ph1_pro4_functions,
-	.functions_count = ARRAY_SIZE(ph1_pro4_functions),
+static struct uniphier_pinctrl_socdata uniphier_pro4_pindata = {
+	.groups = uniphier_pro4_groups,
+	.groups_count = ARRAY_SIZE(uniphier_pro4_groups),
+	.functions = uniphier_pro4_functions,
+	.functions_count = ARRAY_SIZE(uniphier_pro4_functions),
 	.mux_bits = 4,
 	.reg_stride = 8,
 	.load_pinctrl = true,
 };
 
-static struct pinctrl_desc ph1_pro4_pinctrl_desc = {
+static struct pinctrl_desc uniphier_pro4_pinctrl_desc = {
 	.name = DRIVER_NAME,
-	.pins = ph1_pro4_pins,
-	.npins = ARRAY_SIZE(ph1_pro4_pins),
+	.pins = uniphier_pro4_pins,
+	.npins = ARRAY_SIZE(uniphier_pro4_pins),
 	.owner = THIS_MODULE,
 };
 
-static int ph1_pro4_pinctrl_probe(struct platform_device *pdev)
+static int uniphier_pro4_pinctrl_probe(struct platform_device *pdev)
 {
-	return uniphier_pinctrl_probe(pdev, &ph1_pro4_pinctrl_desc,
-				      &ph1_pro4_pindata);
+	return uniphier_pinctrl_probe(pdev, &uniphier_pro4_pinctrl_desc,
+				      &uniphier_pro4_pindata);
 }
 
-static const struct of_device_id ph1_pro4_pinctrl_match[] = {
+static const struct of_device_id uniphier_pro4_pinctrl_match[] = {
 	{ .compatible = "socionext,ph1-pro4-pinctrl" },
 	{ /* sentinel */ }
 };
-MODULE_DEVICE_TABLE(of, ph1_pro4_pinctrl_match);
+MODULE_DEVICE_TABLE(of, uniphier_pro4_pinctrl_match);
 
-static struct platform_driver ph1_pro4_pinctrl_driver = {
-	.probe = ph1_pro4_pinctrl_probe,
+static struct platform_driver uniphier_pro4_pinctrl_driver = {
+	.probe = uniphier_pro4_pinctrl_probe,
 	.driver = {
 		.name = DRIVER_NAME,
-		.of_match_table = ph1_pro4_pinctrl_match,
+		.of_match_table = uniphier_pro4_pinctrl_match,
 	},
 };
-module_platform_driver(ph1_pro4_pinctrl_driver);
+module_platform_driver(uniphier_pro4_pinctrl_driver);
 
 MODULE_AUTHOR("Masahiro Yamada <yamada.masahiro@socionext.com>");
 MODULE_DESCRIPTION("UniPhier PH1-Pro4 pinctrl driver");
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-pro5.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-pro5.c
index 3087f76..a96559c 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-pro5.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-pro5.c
@@ -19,9 +19,9 @@
 
 #include "pinctrl-uniphier.h"
 
-#define DRIVER_NAME "ph1-pro5-pinctrl"
+#define DRIVER_NAME "uniphier-pro5-pinctrl"
 
-static const struct pinctrl_pin_desc ph1_pro5_pins[] = {
+static const struct pinctrl_pin_desc uniphier_pro5_pins[] = {
 	UNIPHIER_PINCTRL_PIN(0, "AEXCKA1", 0,
 			     0, UNIPHIER_PIN_DRV_4_8,
 			     0, UNIPHIER_PIN_PULL_DOWN),
@@ -919,7 +919,7 @@ static const unsigned xirq_alternatives_muxvals[] = {
 	14, 14, 14, 14, 14, 14, 14, 14, 14,
 };
 
-static const struct uniphier_pinctrl_group ph1_pro5_groups[] = {
+static const struct uniphier_pinctrl_group uniphier_pro5_groups[] = {
 	UNIPHIER_PINCTRL_GROUP(nand),
 	UNIPHIER_PINCTRL_GROUP(nand_cs1),
 	UNIPHIER_PINCTRL_GROUP(emmc),
@@ -1291,7 +1291,7 @@ static const char * const xirq_groups[] = {
 	"xirq18b", "xirq18c", "xirq19b", "xirq20b",
 };
 
-static const struct uniphier_pinmux_function ph1_pro5_functions[] = {
+static const struct uniphier_pinmux_function uniphier_pro5_functions[] = {
 	UNIPHIER_PINMUX_FUNCTION(emmc),
 	UNIPHIER_PINMUX_FUNCTION(i2c0),
 	UNIPHIER_PINMUX_FUNCTION(i2c1),
@@ -1312,43 +1312,43 @@ static const struct uniphier_pinmux_function ph1_pro5_functions[] = {
 	UNIPHIER_PINMUX_FUNCTION(xirq),
 };
 
-static struct uniphier_pinctrl_socdata ph1_pro5_pindata = {
-	.groups = ph1_pro5_groups,
-	.groups_count = ARRAY_SIZE(ph1_pro5_groups),
-	.functions = ph1_pro5_functions,
-	.functions_count = ARRAY_SIZE(ph1_pro5_functions),
+static struct uniphier_pinctrl_socdata uniphier_pro5_pindata = {
+	.groups = uniphier_pro5_groups,
+	.groups_count = ARRAY_SIZE(uniphier_pro5_groups),
+	.functions = uniphier_pro5_functions,
+	.functions_count = ARRAY_SIZE(uniphier_pro5_functions),
 	.mux_bits = 4,
 	.reg_stride = 8,
 	.load_pinctrl = true,
 };
 
-static struct pinctrl_desc ph1_pro5_pinctrl_desc = {
+static struct pinctrl_desc uniphier_pro5_pinctrl_desc = {
 	.name = DRIVER_NAME,
-	.pins = ph1_pro5_pins,
-	.npins = ARRAY_SIZE(ph1_pro5_pins),
+	.pins = uniphier_pro5_pins,
+	.npins = ARRAY_SIZE(uniphier_pro5_pins),
 	.owner = THIS_MODULE,
 };
 
-static int ph1_pro5_pinctrl_probe(struct platform_device *pdev)
+static int uniphier_pro5_pinctrl_probe(struct platform_device *pdev)
 {
-	return uniphier_pinctrl_probe(pdev, &ph1_pro5_pinctrl_desc,
-				      &ph1_pro5_pindata);
+	return uniphier_pinctrl_probe(pdev, &uniphier_pro5_pinctrl_desc,
+				      &uniphier_pro5_pindata);
 }
 
-static const struct of_device_id ph1_pro5_pinctrl_match[] = {
+static const struct of_device_id uniphier_pro5_pinctrl_match[] = {
 	{ .compatible = "socionext,ph1-pro5-pinctrl" },
 	{ /* sentinel */ }
 };
-MODULE_DEVICE_TABLE(of, ph1_pro5_pinctrl_match);
+MODULE_DEVICE_TABLE(of, uniphier_pro5_pinctrl_match);
 
-static struct platform_driver ph1_pro5_pinctrl_driver = {
-	.probe = ph1_pro5_pinctrl_probe,
+static struct platform_driver uniphier_pro5_pinctrl_driver = {
+	.probe = uniphier_pro5_pinctrl_probe,
 	.driver = {
 		.name = DRIVER_NAME,
-		.of_match_table = ph1_pro5_pinctrl_match,
+		.of_match_table = uniphier_pro5_pinctrl_match,
 	},
 };
-module_platform_driver(ph1_pro5_pinctrl_driver);
+module_platform_driver(uniphier_pro5_pinctrl_driver);
 
 MODULE_AUTHOR("Masahiro Yamada <yamada.masahiro@socionext.com>");
 MODULE_DESCRIPTION("UniPhier PH1-Pro5 pinctrl driver");
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c
index e868030..8074460e 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c
@@ -19,9 +19,9 @@
 
 #include "pinctrl-uniphier.h"
 
-#define DRIVER_NAME "proxstream2-pinctrl"
+#define DRIVER_NAME "uniphier-pxs2-pinctrl"
 
-static const struct pinctrl_pin_desc proxstream2_pins[] = {
+static const struct pinctrl_pin_desc uniphier_pxs2_pins[] = {
 	UNIPHIER_PINCTRL_PIN(0, "ED0", UNIPHIER_PIN_IECTRL_NONE,
 			     0, UNIPHIER_PIN_DRV_4_8,
 			     0, UNIPHIER_PIN_PULL_DOWN),
@@ -848,7 +848,7 @@ static const unsigned xirq_muxvals[] = {
 	14, 14, 14, 14, 14, 14, 14, 14,			/* XIRQ16-23 */
 };
 
-static const struct uniphier_pinctrl_group proxstream2_groups[] = {
+static const struct uniphier_pinctrl_group uniphier_pxs2_groups[] = {
 	UNIPHIER_PINCTRL_GROUP(emmc),
 	UNIPHIER_PINCTRL_GROUP(emmc_dat8),
 	UNIPHIER_PINCTRL_GROUP(i2c0),
@@ -1208,7 +1208,7 @@ static const char * const xirq_groups[] = {
 	"xirq20", "xirq21", "xirq22", "xirq23",
 };
 
-static const struct uniphier_pinmux_function proxstream2_functions[] = {
+static const struct uniphier_pinmux_function uniphier_pxs2_functions[] = {
 	UNIPHIER_PINMUX_FUNCTION(emmc),
 	UNIPHIER_PINMUX_FUNCTION(i2c0),
 	UNIPHIER_PINMUX_FUNCTION(i2c1),
@@ -1230,43 +1230,43 @@ static const struct uniphier_pinmux_function proxstream2_functions[] = {
 	UNIPHIER_PINMUX_FUNCTION(xirq),
 };
 
-static struct uniphier_pinctrl_socdata proxstream2_pindata = {
-	.groups = proxstream2_groups,
-	.groups_count = ARRAY_SIZE(proxstream2_groups),
-	.functions = proxstream2_functions,
-	.functions_count = ARRAY_SIZE(proxstream2_functions),
+static struct uniphier_pinctrl_socdata uniphier_pxs2_pindata = {
+	.groups = uniphier_pxs2_groups,
+	.groups_count = ARRAY_SIZE(uniphier_pxs2_groups),
+	.functions = uniphier_pxs2_functions,
+	.functions_count = ARRAY_SIZE(uniphier_pxs2_functions),
 	.mux_bits = 8,
 	.reg_stride = 4,
 	.load_pinctrl = false,
 };
 
-static struct pinctrl_desc proxstream2_pinctrl_desc = {
+static struct pinctrl_desc uniphier_pxs2_pinctrl_desc = {
 	.name = DRIVER_NAME,
-	.pins = proxstream2_pins,
-	.npins = ARRAY_SIZE(proxstream2_pins),
+	.pins = uniphier_pxs2_pins,
+	.npins = ARRAY_SIZE(uniphier_pxs2_pins),
 	.owner = THIS_MODULE,
 };
 
-static int proxstream2_pinctrl_probe(struct platform_device *pdev)
+static int uniphier_pxs2_pinctrl_probe(struct platform_device *pdev)
 {
-	return uniphier_pinctrl_probe(pdev, &proxstream2_pinctrl_desc,
-				      &proxstream2_pindata);
+	return uniphier_pinctrl_probe(pdev, &uniphier_pxs2_pinctrl_desc,
+				      &uniphier_pxs2_pindata);
 }
 
-static const struct of_device_id proxstream2_pinctrl_match[] = {
+static const struct of_device_id uniphier_pxs2_pinctrl_match[] = {
 	{ .compatible = "socionext,proxstream2-pinctrl" },
 	{ /* sentinel */ }
 };
-MODULE_DEVICE_TABLE(of, proxstream2_pinctrl_match);
+MODULE_DEVICE_TABLE(of, uniphier_pxs2_pinctrl_match);
 
-static struct platform_driver proxstream2_pinctrl_driver = {
-	.probe = proxstream2_pinctrl_probe,
+static struct platform_driver uniphier_pxs2_pinctrl_driver = {
+	.probe = uniphier_pxs2_pinctrl_probe,
 	.driver = {
 		.name = DRIVER_NAME,
-		.of_match_table = proxstream2_pinctrl_match,
+		.of_match_table = uniphier_pxs2_pinctrl_match,
 	},
 };
-module_platform_driver(proxstream2_pinctrl_driver);
+module_platform_driver(uniphier_pxs2_pinctrl_driver);
 
 MODULE_AUTHOR("Masahiro Yamada <yamada.masahiro@socionext.com>");
 MODULE_DESCRIPTION("UniPhier ProXstream2 pinctrl driver");
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c
index ceb7a98..1e26b96 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c
@@ -19,9 +19,9 @@
 
 #include "pinctrl-uniphier.h"
 
-#define DRIVER_NAME "ph1-sld8-pinctrl"
+#define DRIVER_NAME "uniphier-sld8-pinctrl"
 
-static const struct pinctrl_pin_desc ph1_sld8_pins[] = {
+static const struct pinctrl_pin_desc uniphier_sld8_pins[] = {
 	UNIPHIER_PINCTRL_PIN(0, "PCA00", 0,
 			     15, UNIPHIER_PIN_DRV_4_8,
 			     15, UNIPHIER_PIN_PULL_DOWN),
@@ -529,7 +529,7 @@ static const unsigned xirq_range1_muxvals[] = {
 	14, 14,						/* XIRQ14-15 */
 };
 
-static const struct uniphier_pinctrl_group ph1_sld8_groups[] = {
+static const struct uniphier_pinctrl_group uniphier_sld8_groups[] = {
 	UNIPHIER_PINCTRL_GROUP(emmc),
 	UNIPHIER_PINCTRL_GROUP(emmc_dat8),
 	UNIPHIER_PINCTRL_GROUP(i2c0),
@@ -736,7 +736,7 @@ static const char * const xirq_groups[] = {
 	"xirq12", /* none*/ "xirq14", "xirq15",
 };
 
-static const struct uniphier_pinmux_function ph1_sld8_functions[] = {
+static const struct uniphier_pinmux_function uniphier_sld8_functions[] = {
 	UNIPHIER_PINMUX_FUNCTION(emmc),
 	UNIPHIER_PINMUX_FUNCTION(i2c0),
 	UNIPHIER_PINMUX_FUNCTION(i2c1),
@@ -755,43 +755,43 @@ static const struct uniphier_pinmux_function ph1_sld8_functions[] = {
 	UNIPHIER_PINMUX_FUNCTION(xirq),
 };
 
-static struct uniphier_pinctrl_socdata ph1_sld8_pindata = {
-	.groups = ph1_sld8_groups,
-	.groups_count = ARRAY_SIZE(ph1_sld8_groups),
-	.functions = ph1_sld8_functions,
-	.functions_count = ARRAY_SIZE(ph1_sld8_functions),
+static struct uniphier_pinctrl_socdata uniphier_sld8_pindata = {
+	.groups = uniphier_sld8_groups,
+	.groups_count = ARRAY_SIZE(uniphier_sld8_groups),
+	.functions = uniphier_sld8_functions,
+	.functions_count = ARRAY_SIZE(uniphier_sld8_functions),
 	.mux_bits = 8,
 	.reg_stride = 4,
 	.load_pinctrl = false,
 };
 
-static struct pinctrl_desc ph1_sld8_pinctrl_desc = {
+static struct pinctrl_desc uniphier_sld8_pinctrl_desc = {
 	.name = DRIVER_NAME,
-	.pins = ph1_sld8_pins,
-	.npins = ARRAY_SIZE(ph1_sld8_pins),
+	.pins = uniphier_sld8_pins,
+	.npins = ARRAY_SIZE(uniphier_sld8_pins),
 	.owner = THIS_MODULE,
 };
 
-static int ph1_sld8_pinctrl_probe(struct platform_device *pdev)
+static int uniphier_sld8_pinctrl_probe(struct platform_device *pdev)
 {
-	return uniphier_pinctrl_probe(pdev, &ph1_sld8_pinctrl_desc,
-				      &ph1_sld8_pindata);
+	return uniphier_pinctrl_probe(pdev, &uniphier_sld8_pinctrl_desc,
+				      &uniphier_sld8_pindata);
 }
 
-static const struct of_device_id ph1_sld8_pinctrl_match[] = {
+static const struct of_device_id uniphier_sld8_pinctrl_match[] = {
 	{ .compatible = "socionext,ph1-sld8-pinctrl" },
 	{ /* sentinel */ }
 };
-MODULE_DEVICE_TABLE(of, ph1_sld8_pinctrl_match);
+MODULE_DEVICE_TABLE(of, uniphier_sld8_pinctrl_match);
 
-static struct platform_driver ph1_sld8_pinctrl_driver = {
-	.probe = ph1_sld8_pinctrl_probe,
+static struct platform_driver uniphier_sld8_pinctrl_driver = {
+	.probe = uniphier_sld8_pinctrl_probe,
 	.driver = {
 		.name = DRIVER_NAME,
-		.of_match_table = ph1_sld8_pinctrl_match,
+		.of_match_table = uniphier_sld8_pinctrl_match,
 	},
 };
-module_platform_driver(ph1_sld8_pinctrl_driver);
+module_platform_driver(uniphier_sld8_pinctrl_driver);
 
 MODULE_AUTHOR("Masahiro Yamada <yamada.masahiro@socionext.com>");
 MODULE_DESCRIPTION("UniPhier PH1-sLD8 pinctrl driver");
-- 
1.9.1

From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri,  7 Feb 2014 22:14:14 +0100
Subject: [PATCH v2 1/2] rtc: sunxi: Change compatibles
In-Reply-To: <1391807655-29169-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1391807655-29169-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1391807655-29169-2-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Allwinner A10 compatibles were following a slightly different compatible
patterns than the rest of the SoCs for historical reasons. Change the compatibles
to match the other pattern in the RTC driver for consistency.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 Documentation/devicetree/bindings/rtc/sunxi-rtc.txt | 4 ++--
 drivers/rtc/rtc-sunxi.c                             | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/sunxi-rtc.txt b/Documentation/devicetree/bindings/rtc/sunxi-rtc.txt
index 7cb9dbf3..6983aad 100644
--- a/Documentation/devicetree/bindings/rtc/sunxi-rtc.txt
+++ b/Documentation/devicetree/bindings/rtc/sunxi-rtc.txt
@@ -3,7 +3,7 @@
 RTC controller for the Allwinner A10/A20
 
 Required properties:
-- compatible : Should be "allwinner,sun4i-rtc" or "allwinner,sun7i-a20-rtc"
+- compatible : Should be "allwinner,sun4i-a10-rtc" or "allwinner,sun7i-a20-rtc"
 - reg: physical base address of the controller and length of memory mapped
   region.
 - interrupts: IRQ line for the RTC.
@@ -11,7 +11,7 @@ Required properties:
 Example:
 
 rtc: rtc at 01c20d00 {
-	compatible = "allwinner,sun4i-rtc";
+	compatible = "allwinner,sun4i-a10-rtc";
 	reg = <0x01c20d00 0x20>;
 	interrupts = <24>;
 };
diff --git a/drivers/rtc/rtc-sunxi.c b/drivers/rtc/rtc-sunxi.c
index 68a3528..b6f21f7 100644
--- a/drivers/rtc/rtc-sunxi.c
+++ b/drivers/rtc/rtc-sunxi.c
@@ -428,7 +428,7 @@ static const struct rtc_class_ops sunxi_rtc_ops = {
 };
 
 static const struct of_device_id sunxi_rtc_dt_ids[] = {
-	{ .compatible = "allwinner,sun4i-rtc", .data = &data_year_param[0] },
+	{ .compatible = "allwinner,sun4i-a10-rtc", .data = &data_year_param[0] },
 	{ .compatible = "allwinner,sun7i-a20-rtc", .data = &data_year_param[1] },
 	{ /* sentinel */ },
 };
-- 
1.8.4.2

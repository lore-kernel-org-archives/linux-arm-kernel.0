From: jenskuske@gmail.com (Jens Kuske)
Date: Wed, 21 Oct 2015 18:20:26 +0200
Subject: [PATCH 4/6] reset: sunxi: Add compatible for Allwinner H3 bus resets
Message-ID: <1445444428-4652-1-git-send-email-jenskuske@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding a new compatible allows us to define SoC specific behaviour
if necessary, for example forcing a particular device out of reset
even if no driver is actually using it.

Signed-off-by: Jens Kuske <jenskuske@gmail.com>
---
 Documentation/devicetree/bindings/reset/allwinner,sunxi-clock-reset.txt | 1 +
 drivers/reset/reset-sunxi.c                                             | 1 +
 2 files changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/reset/allwinner,sunxi-clock-reset.txt b/Documentation/devicetree/bindings/reset/allwinner,sunxi-clock-reset.txt
index c8f7757..e11f023 100644
--- a/Documentation/devicetree/bindings/reset/allwinner,sunxi-clock-reset.txt
+++ b/Documentation/devicetree/bindings/reset/allwinner,sunxi-clock-reset.txt
@@ -8,6 +8,7 @@ Required properties:
 - compatible: Should be one of the following:
   "allwinner,sun6i-a31-ahb1-reset"
   "allwinner,sun6i-a31-clock-reset"
+  "allwinner,sun8i-h3-bus-reset"
 - reg: should be register base and length as documented in the
   datasheet
 - #reset-cells: 1, see below
diff --git a/drivers/reset/reset-sunxi.c b/drivers/reset/reset-sunxi.c
index 3d95c87..6f12b5c 100644
--- a/drivers/reset/reset-sunxi.c
+++ b/drivers/reset/reset-sunxi.c
@@ -124,6 +124,7 @@ err_alloc:
  */
 static const struct of_device_id sunxi_early_reset_dt_ids[] __initdata = {
 	{ .compatible = "allwinner,sun6i-a31-ahb1-reset", },
+	{ .compatible = "allwinner,sun8i-h3-bus-reset", },
 	{ /* sentinel */ },
 };
 
-- 
2.6.1

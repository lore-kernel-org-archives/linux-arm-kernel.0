From: sugar.zhang@rock-chips.com (Sugar Zhang)
Date: Fri,  4 Mar 2016 18:31:54 +0800
Subject: [PATCH] ASoC: rockchip: add bindings for spdif controller
Message-ID: <1457087514-1837-1-git-send-email-sugar.zhang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

this patch add compatible for rk3366/rk3368/rk3399 spdif,
these three spdifs share the same type.

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
---

 Documentation/devicetree/bindings/sound/rockchip-spdif.txt |  8 ++++++--
 sound/soc/rockchip/rockchip_spdif.c                        | 13 ++++++++++---
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/rockchip-spdif.txt b/Documentation/devicetree/bindings/sound/rockchip-spdif.txt
index e64dbde..1104642 100644
--- a/Documentation/devicetree/bindings/sound/rockchip-spdif.txt
+++ b/Documentation/devicetree/bindings/sound/rockchip-spdif.txt
@@ -7,8 +7,12 @@ a fibre cable.
 Required properties:
 
 - compatible: should be one of the following:
-   - "rockchip,rk3288-spdif", "rockchip,rk3188-spdif" or
-     "rockchip,rk3066-spdif"
+   - "rockchip,rk3066-spdif"
+   - "rockchip,rk3188-spdif"
+   - "rockchip,rk3288-spdif"
+   - "rockchip,rk3366-spdif"
+   - "rockchip,rk3368-spdif"
+   - "rockchip,rk3399-spdif"
 - reg: physical base address of the controller and length of memory mapped
   region.
 - interrupts: should contain the SPDIF interrupt.
diff --git a/sound/soc/rockchip/rockchip_spdif.c b/sound/soc/rockchip/rockchip_spdif.c
index 5a806da..c589f6f 100644
--- a/sound/soc/rockchip/rockchip_spdif.c
+++ b/sound/soc/rockchip/rockchip_spdif.c
@@ -28,6 +28,7 @@ enum rk_spdif_type {
 	RK_SPDIF_RK3066,
 	RK_SPDIF_RK3188,
 	RK_SPDIF_RK3288,
+	RK_SPDIF_RK3366,
 };
 
 #define RK3288_GRF_SOC_CON2 0x24c
@@ -45,11 +46,17 @@ struct rk_spdif_dev {
 
 static const struct of_device_id rk_spdif_match[] = {
 	{ .compatible = "rockchip,rk3066-spdif",
-	  .data = (void *) RK_SPDIF_RK3066 },
+	  .data = (void *)RK_SPDIF_RK3066 },
 	{ .compatible = "rockchip,rk3188-spdif",
-	  .data = (void *) RK_SPDIF_RK3188 },
+	  .data = (void *)RK_SPDIF_RK3188 },
 	{ .compatible = "rockchip,rk3288-spdif",
-	  .data = (void *) RK_SPDIF_RK3288 },
+	  .data = (void *)RK_SPDIF_RK3288 },
+	{ .compatible = "rockchip,rk3366-spdif",
+	  .data = (void *)RK_SPDIF_RK3366 },
+	{ .compatible = "rockchip,rk3368-spdif",
+	  .data = (void *)RK_SPDIF_RK3366 },
+	{ .compatible = "rockchip,rk3399-spdif",
+	  .data = (void *)RK_SPDIF_RK3366 },
 	{},
 };
 MODULE_DEVICE_TABLE(of, rk_spdif_match);
-- 
1.9.1

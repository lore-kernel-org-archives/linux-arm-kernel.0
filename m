From: sugar.zhang@rock-chips.com (Sugar Zhang)
Date: Fri,  9 Jun 2017 15:59:32 +0800
Subject: [PATCH v1 1/2] ASoC: rockchip: add bindings for spdif controller
In-Reply-To: <1496995173-63532-1-git-send-email-sugar.zhang@rock-chips.com>
References: <1496995173-63532-1-git-send-email-sugar.zhang@rock-chips.com>
Message-ID: <1496995173-63532-2-git-send-email-sugar.zhang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

this patch add compatible for rk3228/rk3328 spdif,

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
---

 Documentation/devicetree/bindings/sound/rockchip-spdif.txt | 2 ++
 sound/soc/rockchip/rockchip_spdif.c                        | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/rockchip-spdif.txt b/Documentation/devicetree/bindings/sound/rockchip-spdif.txt
index 1104642..4706b96 100644
--- a/Documentation/devicetree/bindings/sound/rockchip-spdif.txt
+++ b/Documentation/devicetree/bindings/sound/rockchip-spdif.txt
@@ -9,7 +9,9 @@ Required properties:
 - compatible: should be one of the following:
    - "rockchip,rk3066-spdif"
    - "rockchip,rk3188-spdif"
+   - "rockchip,rk3228-spdif"
    - "rockchip,rk3288-spdif"
+   - "rockchip,rk3328-spdif"
    - "rockchip,rk3366-spdif"
    - "rockchip,rk3368-spdif"
    - "rockchip,rk3399-spdif"
diff --git a/sound/soc/rockchip/rockchip_spdif.c b/sound/soc/rockchip/rockchip_spdif.c
index fa8101d..ee5055d 100644
--- a/sound/soc/rockchip/rockchip_spdif.c
+++ b/sound/soc/rockchip/rockchip_spdif.c
@@ -49,8 +49,12 @@ struct rk_spdif_dev {
 	  .data = (void *)RK_SPDIF_RK3066 },
 	{ .compatible = "rockchip,rk3188-spdif",
 	  .data = (void *)RK_SPDIF_RK3188 },
+	{ .compatible = "rockchip,rk3228-spdif",
+	  .data = (void *)RK_SPDIF_RK3366 },
 	{ .compatible = "rockchip,rk3288-spdif",
 	  .data = (void *)RK_SPDIF_RK3288 },
+	{ .compatible = "rockchip,rk3328-spdif",
+	  .data = (void *)RK_SPDIF_RK3366 },
 	{ .compatible = "rockchip,rk3366-spdif",
 	  .data = (void *)RK_SPDIF_RK3366 },
 	{ .compatible = "rockchip,rk3368-spdif",
-- 
1.9.1

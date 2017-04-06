From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Thu,  6 Apr 2017 20:31:21 +0800
Subject: [PATCH v5 08/12] drm/rockchip: vop: Unprepare clocks when unbinding
In-Reply-To: <1491481885-13775-1-git-send-email-jeffy.chen@rock-chips.com>
References: <1491481885-13775-1-git-send-email-jeffy.chen@rock-chips.com>
Message-ID: <1491481885-13775-9-git-send-email-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clocks are prepared when binding vop.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index b65b296..3f7a82d 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -1634,6 +1634,10 @@ static void vop_unbind(struct device *dev, struct device *master, void *data)
 
 	pm_runtime_disable(dev);
 	vop_destroy_crtc(vop);
+
+	clk_unprepare(vop->aclk);
+	clk_unprepare(vop->hclk);
+	clk_unprepare(vop->dclk);
 }
 
 const struct component_ops vop_component_ops = {
-- 
2.1.4

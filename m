From: you@example.com (Your Name)
Date: Thu,  6 Apr 2017 20:22:20 +0800
Subject: [PATCH v4 09/12] drm/rockchip: analogix_dp: Disable clock when
 unbinding
In-Reply-To: <1491481343-11025-1-git-send-email-you@example.com>
References: <1491481343-11025-1-git-send-email-you@example.com>
Message-ID: <1491481343-11025-10-git-send-email-you@example.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jeffy Chen <jeffy.chen@rock-chips.com>

The clock is enabled when binding cdn dp.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
Signed-off-by: Your Name <you@example.com>
---

Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
index 91ebe5c..c3b9f1d 100644
--- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
@@ -417,7 +417,8 @@ static void rockchip_dp_unbind(struct device *dev, struct device *master,
 
 	rockchip_drm_psr_unregister(&dp->encoder);
 
-	return analogix_dp_unbind(dev, master, data);
+	analogix_dp_unbind(dev, master, data);
+	clk_disable_unprepare(dp->pclk);
 }
 
 static const struct component_ops rockchip_dp_component_ops = {
-- 
2.1.4

From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Tue, 25 Apr 2017 03:16:16 +0000
Subject: [PATCH -next] drm/rockchip: cdn-dp: fix return value check in
 cdn_dp_probe()
Message-ID: <20170425031616.12664-1-weiyj.lk@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <weiyongjun1@huawei.com>

Fix the retrn value check which testing the wrong variable
in cdn_dp_probe().

Fixes: 1a0f7ed3abe2 ("drm/rockchip: cdn-dp: add cdn DP support for rk3399")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/gpu/drm/rockchip/cdn-dp-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c b/drivers/gpu/drm/rockchip/cdn-dp-core.c
index 9ab67a6..6a4a113 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-core.c
+++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c
@@ -1198,7 +1198,7 @@ static int cdn_dp_probe(struct platform_device *pdev)
 			continue;
 
 		port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
-		if (!dp)
+		if (!port)
 			return -ENOMEM;
 
 		port->extcon = extcon;

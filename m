From: mark.yao@rock-chips.com (Mark Yao)
Date: Mon, 27 Jul 2015 10:08:27 +0800
Subject: [PATCH v4 5/6] drm/rockchip: vop: restore vop registers when resume
In-Reply-To: <1437962762-19157-1-git-send-email-mark.yao@rock-chips.com>
References: <1437962762-19157-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <1437962907-19229-1-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The registers will be reset to default values when whole
power domain off, so restore registers from regsbak.

Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
---
Changes in v4: None

 drivers/gpu/drm/rockchip/rockchip_drm_vop.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 4a2923b..16b7d98 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -496,6 +496,7 @@ static void vop_enable(struct drm_crtc *crtc)
 		goto err_disable_aclk;
 	}
 
+	memcpy(vop->regs, vop->regsbak, vop->len);
 	/*
 	 * At here, vop clock & iommu is enable, R/W vop regs would be safe.
 	 */
-- 
1.7.9.5

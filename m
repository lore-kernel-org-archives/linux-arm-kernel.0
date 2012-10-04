From: rahul.sharma@samsung.com (Rahul Sharma)
Date: Thu, 04 Oct 2012 21:12:43 +0530
Subject: [PATCH v1 05/14] drm: exynos: hdmi: turn off HPD interrupt in HDMI
 chip
In-Reply-To: <1349365372-21417-1-git-send-email-rahul.sharma@samsung.com>
References: <1349365372-21417-1-git-send-email-rahul.sharma@samsung.com>
Message-ID: <1349365372-21417-6-git-send-email-rahul.sharma@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tomasz Stanislawski <t.stanislaws@samsung.com>

The plug/unplug interrupt are handled by a separate interrupt.
So there is no need to replicate this mechanism in HDMI core.

Signed-off-by: Tomasz Stanislawski <t.stanislaws@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/gpu/drm/exynos/exynos_hdmi.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_hdmi.c b/drivers/gpu/drm/exynos/exynos_hdmi.c
index 90dce8c..e3ab840 100644
--- a/drivers/gpu/drm/exynos/exynos_hdmi.c
+++ b/drivers/gpu/drm/exynos/exynos_hdmi.c
@@ -1532,12 +1532,9 @@ static void hdmi_conf_reset(struct hdmi_context *hdata)
 
 static void hdmi_conf_init(struct hdmi_context *hdata)
 {
-	/* enable HPD interrupts */
+	/* disable HPD interrupts */
 	hdmi_reg_writemask(hdata, HDMI_INTC_CON, 0, HDMI_INTC_EN_GLOBAL |
 		HDMI_INTC_EN_HPD_PLUG | HDMI_INTC_EN_HPD_UNPLUG);
-	mdelay(10);
-	hdmi_reg_writemask(hdata, HDMI_INTC_CON, ~0, HDMI_INTC_EN_GLOBAL |
-		HDMI_INTC_EN_HPD_PLUG | HDMI_INTC_EN_HPD_UNPLUG);
 
 	/* choose HDMI mode */
 	hdmi_reg_writemask(hdata, HDMI_MODE_SEL,
-- 
1.7.0.4

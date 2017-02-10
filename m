From: yannick.fertre@st.com (Yannick Fertre)
Date: Fri, 10 Feb 2017 15:54:43 +0100
Subject: [PATCH v2 3/9] drm/st: Add STM32 LTDC driver
In-Reply-To: <1486738489-22154-1-git-send-email-yannick.fertre@st.com>
References: <1486738489-22154-1-git-send-email-yannick.fertre@st.com>
Message-ID: <1486738489-22154-4-git-send-email-yannick.fertre@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for the STM32 LCD-TFT display controller.

Signed-off-by: Yannick Fertre <yannick.fertre@st.com>
---
 drivers/gpu/drm/stm/ltdc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
index 0a393e2..148607d 100644
--- a/drivers/gpu/drm/stm/ltdc.c
+++ b/drivers/gpu/drm/stm/ltdc.c
@@ -1246,7 +1246,7 @@ int ltdc_load(struct drm_device *ddev)
 
 	mutex_init(&ltdc->err_lock);
 
-	ltdc->pixel_clk = devm_clk_get(dev, "clk-lcd");
+	ltdc->pixel_clk = devm_clk_get(dev, "lcd");
 	if (IS_ERR(ltdc->pixel_clk)) {
 		DRM_ERROR("Unable to get lcd clock\n");
 		return -ENODEV;
@@ -1263,7 +1263,7 @@ int ltdc_load(struct drm_device *ddev)
 		return PTR_ERR(regs);
 	}
 
-	ltdc->map = devm_regmap_init_mmio_clk(dev, "clk-lcd", regs,
+	ltdc->map = devm_regmap_init_mmio_clk(dev, "lcd", regs,
 					      &ltdc_regmap_config);
 	if (IS_ERR(ltdc->map)) {
 		dev_err(dev, "Couldn't create ltdc register mapping\n");
-- 
1.9.1

From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri,  2 Mar 2018 10:14:26 +0100
Subject: [PATCH v3] bridge: Elaborate a bit on dumb VGA bridges in Kconfig
Message-ID: <20180302091426.8463-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's better if we explain a bit that this pertains to
non-programmable VGA DAC bridges.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- Fix wording and commit message.
- Collect Laurent's review tag.
ChangeLog v1->v2:
- Write that these bridges are non-programmable rather than
  discrete, as that reflects the name of the bridge being
  "dumb". Discrete is wrong as it has a specific electronic
  meaning, as in "non-integrated" and this is integrated.
---
 drivers/gpu/drm/bridge/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index 3b99d5a06c16..3aa65bdecb0e 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -30,7 +30,8 @@ config DRM_DUMB_VGA_DAC
 	depends on OF
 	select DRM_KMS_HELPER
 	help
-	  Support for RGB to VGA DAC based bridges
+	  Support for non-programmable RGB to VGA DAC bridges, such as ADI
+	  ADV7123, TI THS8134 and THS8135 or passive resistor ladder DACs.
 
 config DRM_LVDS_ENCODER
 	tristate "Transparent parallel to LVDS encoder support"
-- 
2.14.3

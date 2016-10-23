From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Sun, 23 Oct 2016 20:10:44 +0100
Subject: [PATCH RFC 04/10] drm/i2c: tda998x: correct function name in comments
In-Reply-To: <20161023191002.GJ1041@n2100.armlinux.org.uk>
References: <20161023191002.GJ1041@n2100.armlinux.org.uk>
Message-ID: <E1byOAO-0005yq-9k@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Correct two references to tda998x_connector_get_modes() which were
incorrectly referring to tda998x_encoder_get_modes().

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/gpu/drm/i2c/tda998x_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index 858237f7f4d6..134cd3f26a07 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -581,9 +581,9 @@ tda998x_reset(struct tda998x_priv *priv)
  * HPD assertion: it needs a delay of 100ms to avoid timing out while
  * trying to read EDID data.
  *
- * However, tda998x_encoder_get_modes() may be called at any moment
+ * However, tda998x_connector_get_modes() may be called at any moment
  * after tda998x_connector_detect() indicates that we are connected, so
- * we need to delay probing modes in tda998x_encoder_get_modes() after
+ * we need to delay probing modes in tda998x_connector_get_modes() after
  * we have seen a HPD inactive->active transition.  This code implements
  * that delay.
  */
-- 
2.1.0

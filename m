From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 16 Nov 2017 00:18:11 +0100
Subject: [PATCH for sre] Fix "backlight" on N9
Message-ID: <20171115231811.GA25191@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

This should get "backlight" to work on N9/N950.

First hunk may not apply to you.

Signed-off-by: Pavel Machek <pavel@ucw.cz>

diff --git a/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c b/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
index 24b459e..57827a1 100644
--- a/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
+++ b/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
@@ -374,8 +374,6 @@ static int dsicm_bl_update_status(struct backlight_device *dev)
 	else
 		level = 0;
 
-	level = 0xff;
-
 	dev_dbg(&ddata->pdev->dev, "update brightness to %d\n", level);
 
 	mutex_lock(&ddata->lock);
@@ -1382,6 +1380,7 @@ static int dsicm_probe(struct platform_device *pdev)
 	if (ddata->use_dsi_backlight) {
 		struct backlight_properties props = { 0 };
 		props.max_brightness = 255;
+		props.brightness = 128;
 		props.type = BACKLIGHT_RAW;
 
 		bldev = devm_backlight_device_register(dev, dev_name(dev),

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171116/d2f85956/attachment.sig>

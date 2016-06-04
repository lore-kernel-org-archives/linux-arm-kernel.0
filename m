From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat,  4 Jun 2016 10:10:02 +0300
Subject: [PATCH 10/22] video: clps711x-fb: Changing the compatibility string
 to match with the smallest supported chip
In-Reply-To: <1465024214-22120-1-git-send-email-shc_work@mail.ru>
References: <1465024214-22120-1-git-send-email-shc_work@mail.ru>
Message-ID: <1465024214-22120-11-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch changes the compatibility string to match with the smallest
supported chip (EP7209). Since the DT-support for this CPU is not yet
announced, this change is safe.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 Documentation/devicetree/bindings/display/cirrus,clps711x-fb.txt | 4 ++--
 drivers/video/fbdev/clps711x-fb.c                                | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/cirrus,clps711x-fb.txt b/Documentation/devicetree/bindings/display/cirrus,clps711x-fb.txt
index d685be8..e9c6574 100644
--- a/Documentation/devicetree/bindings/display/cirrus,clps711x-fb.txt
+++ b/Documentation/devicetree/bindings/display/cirrus,clps711x-fb.txt
@@ -1,7 +1,7 @@
 * Currus Logic CLPS711X Framebuffer
 
 Required properties:
-- compatible: Shall contain "cirrus,clps711x-fb".
+- compatible: Shall contain "cirrus,ep7209-fb".
 - reg       : Physical base address and length of the controller's registers +
               location and size of the framebuffer memory.
 - clocks    : phandle + clock specifier pair of the FB reference clock.
@@ -18,7 +18,7 @@ Optional properties:
 
 Example:
 	fb: fb at 800002c0 {
-		compatible = "cirrus,ep7312-fb", "cirrus,clps711x-fb";
+		compatible = "cirrus,ep7312-fb", "cirrus,ep7209-fb";
 		reg = <0x800002c0 0xd44>, <0x60000000 0xc000>;
 		clocks = <&clks 2>;
 		lcd-supply = <&reg5v0>;
diff --git a/drivers/video/fbdev/clps711x-fb.c b/drivers/video/fbdev/clps711x-fb.c
index 649b32f..ff56107 100644
--- a/drivers/video/fbdev/clps711x-fb.c
+++ b/drivers/video/fbdev/clps711x-fb.c
@@ -273,7 +273,7 @@ static int clps711x_fb_probe(struct platform_device *pdev)
 	}
 
 	cfb->syscon =
-		syscon_regmap_lookup_by_compatible("cirrus,clps711x-syscon1");
+		syscon_regmap_lookup_by_compatible("cirrus,ep7209-syscon1");
 	if (IS_ERR(cfb->syscon)) {
 		ret = PTR_ERR(cfb->syscon);
 		goto out_fb_release;
@@ -376,7 +376,7 @@ static int clps711x_fb_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id clps711x_fb_dt_ids[] = {
-	{ .compatible = "cirrus,clps711x-fb", },
+	{ .compatible = "cirrus,ep7209-fb", },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, clps711x_fb_dt_ids);
-- 
2.4.9

From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 23 Feb 2015 16:28:09 +0100
Subject: [PATCH 1/2] touchscreen devicetree binding: Add touchscreen-swap-x-y
 property
Message-ID: <1424705290-19172-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On devices with a native portrait screen a landscape touchscreen / digitizer
may be used, this happens e.g. on ebook readers. In this case the X and Y
axis of the touchscreen are swapped compared to the screen.

Add a touchscreen-swap-x-y property which drivers can use to see if they
need to swap the axis to make the touchscreen coordinates match the screen
coordinates.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt b/Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
index d8e0616..12401a1 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
@@ -16,6 +16,8 @@ Optional properties for Touchscreens:
 				  controller)
  - touchscreen-inverted-x	: X axis is inverted (boolean)
  - touchscreen-inverted-y	: Y axis is inverted (boolean)
+ - touchscreen-swap-x-y		: X and Y axis are swapped (boolean)
+				  Swapping is done after inverting the axis
 
 Deprecated properties for Touchscreens:
  - x-size			: deprecated name for touchscreen-size-x
-- 
2.3.0

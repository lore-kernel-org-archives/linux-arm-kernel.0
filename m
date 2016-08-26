From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 26 Aug 2016 16:42:23 +0200
Subject: [PATCH 1/4] ARM: dts: sun4i: Disable ohci1 on ba10-tv-box
Message-ID: <20160826144226.29969-1-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ehci1/ohci1 pair on the ba10-tv-box is connected to an USB-2 wifi
module soldered on the PCB, so there enabling ohci1 is not necessary.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts b/arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts
index f3cb297..5f98582 100644
--- a/arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts
+++ b/arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts
@@ -121,10 +121,6 @@
 	status = "okay";
 };
 
-&ohci1 {
-	status = "okay";
-};
-
 &otg_sram {
 	status = "okay";
 };
-- 
2.9.3

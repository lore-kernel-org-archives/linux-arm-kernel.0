From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Fri,  1 Aug 2014 06:54:56 +0200
Subject: [PATCH v5 09/10] ARM: dts: Simplify USB3503 on exynos5250-arndale
In-Reply-To: <1406868897-26874-1-git-send-email-afaerber@suse.de>
References: <1406868897-26874-1-git-send-email-afaerber@suse.de>
Message-ID: <1406868897-26874-10-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There's no need for a simple-bus, place the smsc,usb3503a directly into
the root node. That's what we're going to do on exynos5250-spring.

Reported-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v5: New
 Aligns with Spring's new USB3503 node.

 arch/arm/boot/dts/exynos5250-arndale.dts | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250-arndale.dts b/arch/arm/boot/dts/exynos5250-arndale.dts
index a04a875346aa..9912d27492db 100644
--- a/arch/arm/boot/dts/exynos5250-arndale.dts
+++ b/arch/arm/boot/dts/exynos5250-arndale.dts
@@ -108,18 +108,12 @@
 		};
 	};
 
-	usb_hub_bus {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <0>;
+	// SMSC USB3503 connected in hardware only mode as a PHY
+	usb_hub: usb-hub {
+		compatible = "smsc,usb3503a";
 
-		// SMSC USB3503 connected in hardware only mode as a PHY
-		usb_hub: usb_hub {
-			compatible = "smsc,usb3503a";
-
-			reset-gpios = <&gpx3 5 GPIO_ACTIVE_LOW>;
-			connect-gpios = <&gpd1 7 GPIO_ACTIVE_LOW>;
-		};
+		reset-gpios = <&gpx3 5 GPIO_ACTIVE_LOW>;
+		connect-gpios = <&gpd1 7 GPIO_ACTIVE_LOW>;
 	};
 };
 
-- 
1.9.3

From: dianders@chromium.org (Doug Anderson)
Date: Wed, 13 Mar 2013 10:18:18 -0700
Subject: [PATCH] ARM: dts: add usb 2.0 clock references to exynos5250 device
 tree
Message-ID: <1363195099-15919-1-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a fixup to two device tree nodes that have already landed but
without clock nodes since the transition to common clock happened at
the same time.

Signed-off-by: Doug Anderson <dianders@chromium.org>
---
 arch/arm/boot/dts/exynos5250.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 24c52e6..59be603 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -402,12 +402,18 @@
 		compatible = "samsung,exynos4210-ehci";
 		reg = <0x12110000 0x100>;
 		interrupts = <0 71 0>;
+
+		clocks = <&clock 285>;
+		clock-names = "usbhost";
 	};
 
 	usb at 12120000 {
 		compatible = "samsung,exynos4210-ohci";
 		reg = <0x12120000 0x100>;
 		interrupts = <0 71 0>;
+
+		clocks = <&clock 285>;
+		clock-names = "usbhost";
 	};
 
 	amba {
-- 
1.8.1.3

From: v1ron@v1ros.org (Roman Volkov)
Date: Fri, 16 Jan 2015 13:42:24 +0300
Subject: [PATCH] dts: vt8500: Add SDHC node to DTS file for WM8650
Message-ID: <1421404944-2508-1-git-send-email-v1ron@v1ros.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current kernel contains SDHC driver but not DTS node for it.
Add missing node to make SDHC controller working by default on WM8650.

Signed-off-by: Roman Volkov <v1ron@v1ros.org>
---
 arch/arm/boot/dts/wm8650.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/wm8650.dtsi b/arch/arm/boot/dts/wm8650.dtsi
index b1c59a7..a7c9989 100644
--- a/arch/arm/boot/dts/wm8650.dtsi
+++ b/arch/arm/boot/dts/wm8650.dtsi
@@ -187,6 +187,15 @@
 			interrupts = <43>;
 		};
 
+		sdhc at d800a000 {
+			compatible = "wm,wm8505-sdhc";
+			reg = <0xd800a000 0x1000>;
+			interrupts = <20 21>;
+			clocks = <&clksdhc>;
+			bus-width = <4>;
+			sdon-inverted;
+		};
+
 		fb: fb at d8050800 {
 			compatible = "wm,wm8505-fb";
 			reg = <0xd8050800 0x200>;
-- 
2.2.1

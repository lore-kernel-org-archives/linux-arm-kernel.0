From: v1ron@v1ros.org (Roman Volkov)
Date: Thu,  5 Feb 2015 13:07:58 +0300
Subject: [PATCH v2 RESEND] dts: vt8500: Add SDHC node to DTS file for WM8650
In-Reply-To: <1423130066-3666-1-git-send-email-v1ron@v1ros.org>
References: <1423130066-3666-1-git-send-email-v1ron@v1ros.org>
Message-ID: <1423130878-3894-1-git-send-email-v1ron@v1ros.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no DT node for SDHC controller for WM8650, while the driver already
exists. Add missing node to make the controller working by default.

Signed-off-by: Roman Volkov <v1ron@v1ros.org>
Reviewed-by: Alexey Charkov <alchark@gmail.com>
---
 arch/arm/boot/dts/wm8650.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/wm8650.dtsi b/arch/arm/boot/dts/wm8650.dtsi
index b1c59a7..e12213d 100644
--- a/arch/arm/boot/dts/wm8650.dtsi
+++ b/arch/arm/boot/dts/wm8650.dtsi
@@ -187,6 +187,15 @@
 			interrupts = <43>;
 		};
 
+		sdhc at d800a000 {
+			compatible = "wm,wm8505-sdhc";
+			reg = <0xd800a000 0x400>;
+			interrupts = <20>, <21>;
+			clocks = <&clksdhc>;
+			bus-width = <4>;
+			sdon-inverted;
+		};
+
 		fb: fb at d8050800 {
 			compatible = "wm,wm8505-fb";
 			reg = <0xd8050800 0x200>;
-- 
2.2.2

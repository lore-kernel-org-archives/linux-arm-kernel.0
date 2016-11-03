From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu,  3 Nov 2016 15:29:25 +0100
Subject: [RFC PATCH 3/3] ARM64: dts: meson-gxbb: Add support for PM and
 Virtual RTC
In-Reply-To: <1478183365-23708-1-git-send-email-narmstrong@baylibre.com>
References: <1478183365-23708-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1478183365-23708-4-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index 2d69a3b..6c08d21 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -56,6 +56,10 @@
 		};
 	};
 
+	system-suspend {
+		compatible = "amlogic,meson-gx-pm";
+	};
+
 	efuse: efuse {
 		compatible = "amlogic,meson-gxbb-efuse";
 		#address-cells = <1>;
@@ -355,6 +359,11 @@
 		#reset-cells = <1>;
 	};
 
+	vrtc: rtc at 0a8 {
+		compatible = "amlogic,meson-vrtc";
+		reg = <0x0 0x000a8 0x0 0x4>;
+	};
+
 	ir: ir at 580 {
 		compatible = "amlogic,meson-gxbb-ir";
 		reg = <0x0 0x00580 0x0 0x40>;
-- 
1.9.1

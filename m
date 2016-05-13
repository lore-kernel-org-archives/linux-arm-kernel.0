From: narmstrong@baylibre.com (Neil Armstrong)
Date: Fri, 13 May 2016 16:00:12 +0200
Subject: [RFC PATCH 3/3] ARM64: dts: amlogic: Enable Reset Controller on
 GXBB-based platforms
In-Reply-To: <1463148012-25988-1-git-send-email-narmstrong@baylibre.com>
References: <1463148012-25988-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1463148012-25988-4-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update DTSI file to add the reset controller node.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index 832815d..2b8fc0d 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -122,6 +122,12 @@
 		#size-cells = <2>;
 		ranges;
 
+		reset: reset-controller at c1004404 {
+			compatible = "amlogic,meson-gxbb-reset";
+			reg = <0x0 0xc1004404 0x0 0x1c>;
+			#reset-cells = <1>;
+		};
+
 		cbus: cbus at c1100000 {
 			compatible = "simple-bus";
 			reg = <0x0 0xc1100000 0x0 0x100000>;
-- 
2.7.0

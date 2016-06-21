From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue, 21 Jun 2016 12:02:53 +0200
Subject: [RFC PATCH v2 8/9] ARM64: dts: meson-gxbb: Add SRAM node
In-Reply-To: <1466503374-28841-1-git-send-email-narmstrong@baylibre.com>
References: <1466503374-28841-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1466503374-28841-9-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index 77381d0..913ba86 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -124,6 +124,15 @@
 		#size-cells = <2>;
 		ranges;
 
+		sram: sram at c8000000 {
+			compatible = "amlogic,meson-gxbb-sram", "mmio-sram";
+			reg = <0x0 0xc8000000 0x0 0x14000>;
+
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x0 0xc8000000 0x14000>;
+		};
+
 		cbus: cbus at c1100000 {
 			compatible = "simple-bus";
 			reg = <0x0 0xc1100000 0x0 0x100000>;
-- 
2.7.0

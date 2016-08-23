From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue, 23 Aug 2016 13:46:55 +0200
Subject: [PATCH v2 6/7] ARM64: dts: meson-gxbb: Add SRAM node
In-Reply-To: <1471952816-30877-1-git-send-email-narmstrong@baylibre.com>
References: <1471952816-30877-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1471952816-30877-7-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index bdbf6e7..2748007 100644
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
1.9.1

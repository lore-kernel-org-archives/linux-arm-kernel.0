From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed,  5 Oct 2016 09:33:33 +0200
Subject: [PATCH v4 7/8] ARM64: dts: meson-gxbb: Add SRAM node
In-Reply-To: <1475652814-30619-1-git-send-email-narmstrong@baylibre.com>
References: <1475652814-30619-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1475652814-30619-8-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index 443811b..88f98f5 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -94,6 +94,15 @@
 			status = "disabled";
 		};
 
+		sram: sram at c8000000 {
+			compatible = "amlogic,meson-gxbb-sram", "mmio-sram";
+			reg = <0x0 0xc8000000 0x0 0x14000>;
+
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x0 0xc8000000 0x14000>;
+		};
+
 		usb0: usb at c9000000 {
 			compatible = "amlogic,meson-gxbb-usb", "snps,dwc2";
 			reg = <0x0 0xc9000000 0x0 0x40000>;
-- 
1.9.1

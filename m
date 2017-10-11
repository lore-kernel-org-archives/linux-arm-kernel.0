From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed, 11 Oct 2017 17:39:40 +0200
Subject: [PATCH 2/2] ARM64: dts: meson-gx: remove unnecessary uart compatible
In-Reply-To: <1507736380-21019-1-git-send-email-narmstrong@baylibre.com>
References: <1507736380-21019-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1507736380-21019-3-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the switch to documented uart bindings, the old undocumented
compatible binding was left for simplicity.

This patch removes these unneeded compatible strings.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index 2be981a..b772343 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -225,14 +225,14 @@
 			};
 
 			uart_A: serial at 84c0 {
-				compatible = "amlogic,meson-gx-uart", "amlogic,meson-uart";
+				compatible = "amlogic,meson-gx-uart";
 				reg = <0x0 0x84c0 0x0 0x14>;
 				interrupts = <GIC_SPI 26 IRQ_TYPE_EDGE_RISING>;
 				status = "disabled";
 			};
 
 			uart_B: serial at 84dc {
-				compatible = "amlogic,meson-gx-uart", "amlogic,meson-uart";
+				compatible = "amlogic,meson-gx-uart";
 				reg = <0x0 0x84dc 0x0 0x14>;
 				interrupts = <GIC_SPI 75 IRQ_TYPE_EDGE_RISING>;
 				status = "disabled";
@@ -277,7 +277,7 @@
 			};
 
 			uart_C: serial at 8700 {
-				compatible = "amlogic,meson-gx-uart", "amlogic,meson-uart";
+				compatible = "amlogic,meson-gx-uart";
 				reg = <0x0 0x8700 0x0 0x14>;
 				interrupts = <GIC_SPI 93 IRQ_TYPE_EDGE_RISING>;
 				status = "disabled";
@@ -388,14 +388,14 @@
 			};
 
 			uart_AO: serial at 4c0 {
-				compatible = "amlogic,meson-gx-uart", "amlogic,meson-ao-uart", "amlogic,meson-uart";
+				compatible = "amlogic,meson-gx-uart", "amlogic,meson-ao-uart";
 				reg = <0x0 0x004c0 0x0 0x14>;
 				interrupts = <GIC_SPI 193 IRQ_TYPE_EDGE_RISING>;
 				status = "disabled";
 			};
 
 			uart_AO_B: serial at 4e0 {
-				compatible = "amlogic,meson-gx-uart", "amlogic,meson-ao-uart", "amlogic,meson-uart";
+				compatible = "amlogic,meson-gx-uart", "amlogic,meson-ao-uart";
 				reg = <0x0 0x004e0 0x0 0x14>;
 				interrupts = <GIC_SPI 197 IRQ_TYPE_EDGE_RISING>;
 				status = "disabled";
-- 
2.7.4

From: narmstrong@baylibre.com (Neil Armstrong)
Date: Fri,  9 Jun 2017 11:49:13 +0200
Subject: [PATCH v4 4/7] ARM: dts: meson: use meson6 UART compatible like other
 nodes
In-Reply-To: <1497001756-942-1-git-send-email-narmstrong@baylibre.com>
References: <1497001756-942-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1497001756-942-5-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The UART bindings needs specifying a SoC family, use the meson6 family
for the UART nodes like the other nodes.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/boot/dts/meson.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/meson.dtsi b/arch/arm/boot/dts/meson.dtsi
index 8d9c369..ecc9330 100644
--- a/arch/arm/boot/dts/meson.dtsi
+++ b/arch/arm/boot/dts/meson.dtsi
@@ -79,14 +79,14 @@
 			ranges = <0x0 0xc1100000 0x200000>;
 
 			uart_A: serial at 84c0 {
-				compatible = "amlogic,meson-uart";
+				compatible = "amlogic,meson6-uart";
 				reg = <0x84c0 0x18>;
 				interrupts = <0 26 1>;
 				status = "disabled";
 			};
 
 			uart_B: serial at 84dc {
-				compatible = "amlogic,meson-uart";
+				compatible = "amlogic,meson6-uart";
 				reg = <0x84dc 0x18>;
 				interrupts = <0 75 1>;
 				status = "disabled";
@@ -102,7 +102,7 @@
 			};
 
 			uart_C: serial at 8700 {
-				compatible = "amlogic,meson-uart";
+				compatible = "amlogic,meson6-uart";
 				reg = <0x8700 0x18>;
 				interrupts = <0 93 1>;
 				status = "disabled";
@@ -153,7 +153,7 @@
 			};
 
 			uart_AO: serial at 4c0 {
-				compatible = "amlogic,meson-uart";
+				compatible = "amlogic,meson6-uart", "amlogic,meson-ao-uart";
 				reg = <0x4c0 0x18>;
 				interrupts = <0 90 1>;
 				status = "disabled";
-- 
1.9.1

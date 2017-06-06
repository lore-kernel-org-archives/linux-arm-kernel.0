From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue,  6 Jun 2017 11:45:39 +0200
Subject: [PATCH v2 2/3] ARM64: dts: meson-gx: Add SoC info register
In-Reply-To: <1496742340-10307-1-git-send-email-narmstrong@baylibre.com>
References: <1496742340-10307-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1496742340-10307-3-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add node for the Amlogic Meson GX SoC information register.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index 436b875..50d001a 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -365,6 +365,15 @@
 				#reset-cells = <1>;
 			};
 
+			sec_AO: ao-secure at 140 {
+				compatible = "amlogic,meson-gx-ao-secure", "syscon", "simple-mfd";
+				reg = <0x0 0x140 0x0 0x140>;
+
+				chipid {
+					compatible = "amlogic,meson-gx-chipid";
+				};
+			};
+
 			uart_AO: serial at 4c0 {
 				compatible = "amlogic,meson-uart";
 				reg = <0x0 0x004c0 0x0 0x14>;
-- 
1.9.1

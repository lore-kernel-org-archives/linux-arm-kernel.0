From: narmstrong@baylibre.com (Neil Armstrong)
Date: Sun, 18 Nov 2018 14:50:24 +0100
Subject: [PATCH v3 3/3] ARM64: dts: meson-gx: Add Internal Clock Measurer node
In-Reply-To: <20181118135024.30720-1-narmstrong@baylibre.com>
References: <20181118135024.30720-1-narmstrong@baylibre.com>
Message-ID: <20181118135024.30720-4-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Amlogic Meson GX SoCs embeds a clock measurer IP to measure the internal
clock paths frequencies.
This patch adds the node in the top-level meson-gx dtsi.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index f1e5cdbade5e..ed336c7a98a7 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -262,6 +262,11 @@
 				status = "disabled";
 			};
 
+			clock-measure at 8758 {
+				compatible = "amlogic,meson-gx-clk-measure";
+				reg = <0x0 0x8758 0x0 0x10>;
+			};
+
 			i2c_B: i2c at 87c0 {
 				compatible = "amlogic,meson-gx-i2c", "amlogic,meson-gxbb-i2c";
 				reg = <0x0 0x087c0 0x0 0x20>;
-- 
2.19.1

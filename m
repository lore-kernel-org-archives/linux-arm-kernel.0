From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue,  3 Jul 2018 15:21:50 +0200
Subject: [PATCH 3/3] ARM64: dts: meson-gx: Add Internal Clock Measurer node
In-Reply-To: <1530624110-4687-1-git-send-email-narmstrong@baylibre.com>
References: <1530624110-4687-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1530624110-4687-4-git-send-email-narmstrong@baylibre.com>
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
index b8dc4db..7767cab 100644
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
2.7.4

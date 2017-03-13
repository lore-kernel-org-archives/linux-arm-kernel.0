From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Mon, 13 Mar 2017 17:43:17 +0100
Subject: [PATCH 2/4] ARM: dts: dm8168-evm: add the external reference clock
 for SATA
In-Reply-To: <1489423399-3824-1-git-send-email-bgolaszewski@baylibre.com>
References: <1489423399-3824-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <1489423399-3824-3-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This board has an external oscillator supplying the reference clock
signal for SATA. Its rate is fixed at 100Mhz. Add a corresponding
device tree node.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/boot/dts/dm8168-evm.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/dm8168-evm.dts b/arch/arm/boot/dts/dm8168-evm.dts
index 0bf55fa..f13e214 100644
--- a/arch/arm/boot/dts/dm8168-evm.dts
+++ b/arch/arm/boot/dts/dm8168-evm.dts
@@ -25,6 +25,12 @@
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 	};
+
+	sata_refclk: fixedclock0 {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <100000000>;
+	};
 };
 
 &dm816x_pinmux {
-- 
2.9.3

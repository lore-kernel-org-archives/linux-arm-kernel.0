From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sun, 11 Sep 2016 14:39:03 +0200
Subject: [PATCH v2 2/2] ARM64: dts: meson-gxbb: add the SDIO pins
In-Reply-To: <20160911123903.20027-1-martin.blumenstingl@googlemail.com>
References: <20160828164725.19429-1-martin.blumenstingl@googlemail.com>
 <20160911123903.20027-1-martin.blumenstingl@googlemail.com>
Message-ID: <20160911123903.20027-3-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Neil Armstrong <narmstrong@baylibre.com>

This is used to configure the pins of the sd_emmc_a controller to
which an SDIO module is connected (when available).

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index c84cacf..fe2a1fc 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -394,6 +394,25 @@
 					};
 				};
 
+				sdio_pins: sdio {
+					mux {
+						groups = "sdio_d0",
+						       "sdio_d1",
+						       "sdio_d2",
+						       "sdio_d3",
+						       "sdio_cmd",
+						       "sdio_clk";
+						function = "sdio";
+					};
+				};
+
+				sdio_irq_pins: sdio_irq {
+					mux {
+						groups = "sdio_irq";
+						function = "sdio";
+					};
+				};
+
 				uart_a_pins: uart_a {
 					mux {
 						groups = "uart_tx_a",
-- 
2.9.3

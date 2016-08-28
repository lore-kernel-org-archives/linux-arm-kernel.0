From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sun, 28 Aug 2016 18:47:25 +0200
Subject: [PATCH 2/2] ARM64: dts: meson-gxbb: add the SDIO pins
In-Reply-To: <20160828164725.19429-1-martin.blumenstingl@googlemail.com>
References: <20160828164725.19429-1-martin.blumenstingl@googlemail.com>
Message-ID: <20160828164725.19429-3-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This can be passed to the sd_emmc_a controller to which the SDIO module
is connected (when available).

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index e2dae1a..6864523 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -355,6 +355,18 @@
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
 				uart_a_pins: uart_a {
 					mux {
 						groups = "uart_tx_a",
-- 
2.9.3

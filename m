From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 16 Jan 2017 17:57:02 +0100
Subject: [PATCH v3 12/13] arm64: allwinner: a64: add UART1 pin nodes
In-Reply-To: <cover.a06ce1672d7a72ee7f9bbca46fdd223edd6b2313.1484585798.git-series.maxime.ripard@free-electrons.com>
References: <cover.a06ce1672d7a72ee7f9bbca46fdd223edd6b2313.1484585798.git-series.maxime.ripard@free-electrons.com>
Message-ID: <a0dd27c08182f0a8c6d76bab80fb82ac5a9a09f9.1484585798.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andre Przywara <andre.przywara@arm.com>

On many boards UART1 connects to a Bluetooth chip, so add the pinctrl
nodes for the only pins providing access to that UART. That includes
those pins for hardware flow control (RTS/CTS).

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index b371fccc234b..8ffdc24f92ca 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -234,6 +234,16 @@
 				pins = "PB8", "PB9";
 				function = "uart0";
 			};
+
+			uart1_pins: uart1_pins {
+				pins = "PG6", "PG7";
+				function = "uart1";
+			};
+
+			uart1_rts_cts_pins: uart1_rts_cts_pins {
+				pins = "PG8", "PG9";
+				function = "uart1";
+			};
 		};
 
 		uart0: serial at 1c28000 {
-- 
git-series 0.8.11

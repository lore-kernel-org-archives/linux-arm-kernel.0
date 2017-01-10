From: andre.przywara@arm.com (Andre Przywara)
Date: Tue, 10 Jan 2017 01:22:32 +0000
Subject: [PATCH 2/3] arm64: dts: sun50i: add UART1 pin nodes
In-Reply-To: <1484011353-21480-1-git-send-email-andre.przywara@arm.com>
References: <1484011353-21480-1-git-send-email-andre.przywara@arm.com>
Message-ID: <1484011353-21480-3-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On many boards UART1 connects to a Bluetooth chip, so add the pinctrl
nodes for the only pins providing access to that UART. That includes
those pins for hardware flow control (RTS/CTS).

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index f46ae96..419b0b1 100644
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
2.8.2

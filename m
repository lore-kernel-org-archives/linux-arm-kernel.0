From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Fri, 14 Apr 2017 19:13:20 +0200
Subject: [PATCH] arm64: dts: allwinner: a64: Add UART2 pin nodes
Message-ID: <20170414171320.19743-1-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

UART2 is exposed on the Pi connector of Pine64. Make a pinctrl node
available at the SoC level, to simplify enabling UART2 via DT overlay.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 1c64ea2d23f9..61d3a19659bf 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -285,6 +285,11 @@
 				pins = "PG8", "PG9";
 				function = "uart1";
 			};
+
+			uart2_pins: uart2-pins {
+				pins = "PB0", "PB1";
+				function = "uart2";
+			};
 		};
 
 		uart0: serial at 1c28000 {
-- 
2.10.2

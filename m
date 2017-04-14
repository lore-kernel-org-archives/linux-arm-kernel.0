From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Fri, 14 Apr 2017 21:08:04 +0200
Subject: [PATCH] arm64: dts: allwinner: pine64: Add remaining UART aliases
Message-ID: <20170414190804.21865-1-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enabling uart2 node currently leads to a /dev/ttyS1 device, with ttyS0..4
always present, causing confusion on the user's part.

dtc cannot resolve an overlay's &uart2 reference for strings, only for
phandles, so it would need to hardcode the full node path.

Avoid this and enforce reliable numbering by adding serialX aliases for:

UART1 - on Wifi/BT connector
UART2 - on Pi-2 connector
UART3 - on Euler connector
UART4 - on Euler connector

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
index c680ed385da3..db6c0f36999e 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
@@ -52,6 +52,10 @@
 
 	aliases {
 		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
+		serial3 = &uart3;
+		serial4 = &uart4;
 	};
 
 	chosen {
-- 
2.10.2

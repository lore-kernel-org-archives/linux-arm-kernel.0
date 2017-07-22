From: icenowy@aosc.io (Icenowy Zheng)
Date: Sat, 22 Jul 2017 10:28:51 +0800
Subject: [PATCH 2/3] arm64: allwinner: a64: add ethernet0 alias for Pine64
 EMAC node
In-Reply-To: <20170722022852.7868-1-icenowy@aosc.io>
References: <20170722022852.7868-1-icenowy@aosc.io>
Message-ID: <20170722022852.7868-3-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Pine64 (including the Plus models) board uses the A64 chip's
EMAC to provide Ethernet link.

Add the ethernet0 alias in the device tree, in order to let U-Boot
generate a MAC address from the chip's SID.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
index 64cce0d68cae..7a450dcb7a08 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
@@ -51,6 +51,7 @@
 	compatible = "pine64,pine64", "allwinner,sun50i-a64";
 
 	aliases {
+		ethernet0 = &emac;
 		serial0 = &uart0;
 		serial1 = &uart1;
 		serial2 = &uart2;
-- 
2.13.0

From: icenowy@aosc.io (Icenowy Zheng)
Date: Sat, 22 Jul 2017 10:28:52 +0800
Subject: [PATCH 3/3] arm64: allwinner: a64: add ethernet0 alias for SoPine
 EMAC node
In-Reply-To: <20170722022852.7868-1-icenowy@aosc.io>
References: <20170722022852.7868-1-icenowy@aosc.io>
Message-ID: <20170722022852.7868-4-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SoPine official baseboard uses the A64 chip's EMAC to provide an
Ethernet link.

Add the ethernet0 alias in the device tree, in order to let U-Boot
generate a MAC address from the chip's SID.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
index 17eb1cc5bf6b..216e3a5dafae 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
@@ -53,6 +53,7 @@
 		     "allwinner,sun50i-a64";
 
 	aliases {
+		ethernet0 = &emac;
 		serial0 = &uart0;
 	};
 
-- 
2.13.0

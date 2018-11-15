From: icenowy@aosc.io (Icenowy Zheng)
Date: Thu, 15 Nov 2018 11:15:51 +0800
Subject: [PATCH] arm64: dts: allwinner: h6: fix EMAC compatible string sequence
Message-ID: <20181115031551.11756-1-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SoC-specific compatible should come before the fallback compatible
string when multiple compatible strings are present, but the sequence is
wrong currently on H6 EMAC node (A64 fallback before H6 compatible).

Fix the sequence.

Fixes: c8ced5516d23 ("arm64: allwinner: h6: add EMAC device nodes")
Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index 45bbb5116446..d1ed451f4d9e 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -326,8 +326,8 @@
 		};
 
 		emac: ethernet at 5020000 {
-			compatible = "allwinner,sun50i-a64-emac",
-				     "allwinner,sun50i-h6-emac";
+			compatible = "allwinner,sun50i-h6-emac",
+				     "allwinner,sun50i-a64-emac";
 			syscon = <&syscon>;
 			reg = <0x05020000 0x10000>;
 			interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.18.1

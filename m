From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 27 Jan 2017 10:14:30 +0100
Subject: [PATCH 8/9] arm64: dts: r8a7795: Mark EthernetAVB device node disabled
In-Reply-To: <cover.1485508214.git.horms+renesas@verge.net.au>
References: <cover.1485508214.git.horms+renesas@verge.net.au>
Message-ID: <0d1390ff283f6c38595288e7f74da6829896b8b7.1485508214.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Device nodes representing I/O devices should be marked disabled in the
SoC-specific DTS, and overridden by board-specific DTSes where needed.

Fixes: a92843c8a6f8c039 ("arm64: dts: r8a7795: add EthernetAVB device node")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 74a4e1ad057d..eac4f29aa5cd 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -566,6 +566,7 @@
 			phy-mode = "rgmii-id";
 			#address-cells = <1>;
 			#size-cells = <0>;
+			status = "disabled";
 		};
 
 		can0: can at e6c30000 {
-- 
2.7.0.rc3.207.g0ac5344

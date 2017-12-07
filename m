From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  7 Dec 2017 10:53:34 +0100
Subject: [PATCH 31/54] arm64: dts: renesas: r8a7795: Connect SATA to IPMMU-HC
In-Reply-To: <cover.1512640145.git.horms+renesas@verge.net.au>
References: <cover.1512640145.git.horms+renesas@verge.net.au>
Message-ID: <0703824ca960ef855e5bc1239e03be520748fb5a.1512640145.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Add IPMMU-HC to the SATA device node.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index f5ab1c3370e6..08c125cfa5d6 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -1645,6 +1645,7 @@
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			resets = <&cpg 815>;
 			status = "disabled";
+			iommus = <&ipmmu_hc 2>;
 		};
 
 		xhci0: usb at ee000000 {
-- 
2.11.0

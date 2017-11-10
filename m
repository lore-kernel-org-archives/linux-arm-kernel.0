From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 10 Nov 2017 14:25:30 +0100
Subject: [PATCH v5 13/15] arm64: dts: renesas: r8a7795: Connect SATA to
 IPMMU-HC
In-Reply-To: <20171110132532.1202-1-horms+renesas@verge.net.au>
References: <20171110132532.1202-1-horms+renesas@verge.net.au>
Message-ID: <20171110132532.1202-14-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Add IPMMU-HC to the SATA device node.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v5 [Simon Horman]
* Added reviewed by tag from Geert Uytterhoeven

v4 [Simon Horman]

v1 - v3 [Magnus Damm]
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 0fd1d1ab97d2..f42387473a9c 100644
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

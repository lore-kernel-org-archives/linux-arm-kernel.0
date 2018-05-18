From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 May 2018 13:15:01 +0200
Subject: [PATCH 039/102] arm64: dts: renesas: r8a77980: add PFC support
In-Reply-To: <cover.1526637994.git.horms+renesas@verge.net.au>
References: <cover.1526637994.git.horms+renesas@verge.net.au>
Message-ID: <cef26946f247c75a3b1c7919ea801d2ea8511f00.1526637994.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Define the generic R8A77980 part of the PFC device node.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a77980.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77980.dtsi b/arch/arm64/boot/dts/renesas/r8a77980.dtsi
index 03845fd74996..08c6708eb9dd 100644
--- a/arch/arm64/boot/dts/renesas/r8a77980.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77980.dtsi
@@ -71,6 +71,11 @@
 		#size-cells = <2>;
 		ranges;
 
+		pfc: pin-controller at e6060000 {
+			compatible = "renesas,pfc-r8a77980";
+			reg = <0 0xe6060000 0 0x50c>;
+		};
+
 		cpg: clock-controller at e6150000 {
 			compatible = "renesas,r8a77980-cpg-mssr";
 			reg = <0 0xe6150000 0 0x1000>;
-- 
2.11.0

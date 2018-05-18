From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 May 2018 13:15:48 +0200
Subject: [PATCH 086/102] arm64: dts: renesas: r8a77980: add resets property to
 CAN-FD node
In-Reply-To: <cover.1526637994.git.horms+renesas@verge.net.au>
References: <cover.1526637994.git.horms+renesas@verge.net.au>
Message-ID: <22fb06cd54f92132bf7a8b7740abc7db79a5130b.1526637994.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add resets property to CAN-FD node to describe it in the reset topology of
on-SoC devices.  This allows to reset the CAN-FD device using the Reset
Controller API.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/boot/dts/renesas/r8a77980.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77980.dtsi b/arch/arm64/boot/dts/renesas/r8a77980.dtsi
index 3a127643d1dc..32db26f2c8b5 100644
--- a/arch/arm64/boot/dts/renesas/r8a77980.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77980.dtsi
@@ -190,6 +190,7 @@
 			assigned-clocks = <&cpg CPG_CORE R8A77980_CLK_CANFD>;
 			assigned-clock-rates = <40000000>;
 			power-domains = <&sysc R8A77980_PD_ALWAYS_ON>;
+			resets = <&cpg 914>;
 			status = "disabled";
 
 			channel0 {
-- 
2.11.0

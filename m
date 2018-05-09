From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  9 May 2018 19:54:09 +0200
Subject: [PATCH] arm64: dts: renesas: r8a77980: add resets property CAN-FD node
Message-ID: <20180509175409.10507-1-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add resets property to CAN-FD node to describe it in the reset topology of
on-SoC devices.  This allows to reset the CAN-FD device using the Reset
Controller API.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
Based on renesas-devel-20180508-v4.17-rc4
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

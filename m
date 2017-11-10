From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 10 Nov 2017 14:26:11 +0100
Subject: [PATCH v2 6/7] arm64: dts: renesas: r8a7796: Connect Ethernet-AVB to
 IPMMU-DS0
In-Reply-To: <20171110132612.1589-1-horms+renesas@verge.net.au>
References: <20171110132612.1589-1-horms+renesas@verge.net.au>
Message-ID: <20171110132612.1589-7-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add IPMMU-DS0 to the Ethernet-AVB device node.

Based on work by Magnus Damm for the r8a7795.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2
* Added reviewed by tag from Geert Uytterhoeven
---
 arch/arm64/boot/dts/renesas/r8a7796.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7796.dtsi b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
index 47250b0c9ee9..530de7176a6f 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
@@ -916,6 +916,7 @@
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
 			resets = <&cpg 812>;
 			phy-mode = "rgmii-txid";
+			iommus = <&ipmmu_ds0 16>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
-- 
2.11.0

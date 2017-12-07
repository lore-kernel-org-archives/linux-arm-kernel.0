From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  7 Dec 2017 10:53:50 +0100
Subject: [PATCH 47/54] arm64: dts: renesas: r8a77970: Connect Ethernet-AVB to
 IPMMU-RT
In-Reply-To: <cover.1512640145.git.horms+renesas@verge.net.au>
References: <cover.1512640145.git.horms+renesas@verge.net.au>
Message-ID: <0639be574ea246d65565b0bfe490a84baaee3d61.1512640145.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add IPMMU-RT to the Ethernet-AVB device node.

Based on work by Magnus Damm for the r8a7795.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/boot/dts/renesas/r8a77970.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77970.dtsi b/arch/arm64/boot/dts/renesas/r8a77970.dtsi
index 108c6159c847..0f93484e650a 100644
--- a/arch/arm64/boot/dts/renesas/r8a77970.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77970.dtsi
@@ -440,6 +440,7 @@
 			power-domains = <&sysc 32>;
 			resets = <&cpg 812>;
 			phy-mode = "rgmii-id";
+			iommus = <&ipmmu_rt 3>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
-- 
2.11.0

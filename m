From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 Mar 2018 15:51:31 +0100
Subject: [PATCH 61/69] arm64: dts: renesas: r8a77970: Set EtherAVB phy mode to
 "rgmii"
In-Reply-To: <cover.1521206129.git.horms+renesas@verge.net.au>
References: <cover.1521206129.git.horms+renesas@verge.net.au>
Message-ID: <95c969d12ea19062077448a0081dc657232edd1d.1521206129.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jacopo Mondi <jacopo+renesas@jmondi.org>

Set the "phy-mode" property of EtherAVB device to "rgmii" and let board
files override it if the installed PHY layer provides delays for the
RX/TX channels.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a77970.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a77970.dtsi b/arch/arm64/boot/dts/renesas/r8a77970.dtsi
index 31eeca1531f6..13ff4305416e 100644
--- a/arch/arm64/boot/dts/renesas/r8a77970.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77970.dtsi
@@ -519,7 +519,7 @@
 			clocks = <&cpg CPG_MOD 812>;
 			power-domains = <&sysc R8A77970_PD_ALWAYS_ON>;
 			resets = <&cpg 812>;
-			phy-mode = "rgmii-id";
+			phy-mode = "rgmii";
 			iommus = <&ipmmu_rt 3>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
2.11.0

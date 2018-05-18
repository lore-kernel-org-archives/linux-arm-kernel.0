From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 May 2018 13:15:50 +0200
Subject: [PATCH 088/102] arm64: dts: renesas: r8a77970: disable EtherAVB
In-Reply-To: <cover.1526637994.git.horms+renesas@verge.net.au>
References: <cover.1526637994.git.horms+renesas@verge.net.au>
Message-ID: <9223eef03f2659bd9650c2bc4364b1748e62eade.1526637994.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

When adding the R8A77970 EtherAVB device I failed to notice that it does
not have the usual "status" property disabling the described devices in
anticipation that the board device trees enable the devices according to
their needs. This causes the EtherAVB driver to successfully probe despite
e.g. the needed pins not having been configured -- luckily, "eth<n>" device
can't be opened anyway...

Fixes: bea2ab136eaa ("arm64: dts: renesas: r8a77970: add EtherAVB support")
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a77970.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77970.dtsi b/arch/arm64/boot/dts/renesas/r8a77970.dtsi
index 50046405d348..c8464d1ef1b2 100644
--- a/arch/arm64/boot/dts/renesas/r8a77970.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77970.dtsi
@@ -473,6 +473,7 @@
 			iommus = <&ipmmu_rt 3>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			status = "disabled";
 		};
 
 		scif0: serial at e6e60000 {
-- 
2.11.0

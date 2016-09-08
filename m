From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  8 Sep 2016 09:43:18 +0200
Subject: [PATCH 22/30] arm64: dts: r8a7795: remove unnecessary
 cap-mmc-highspeed property
In-Reply-To: <cover.1473320411.git.horms+renesas@verge.net.au>
References: <cover.1473320411.git.horms+renesas@verge.net.au>
Message-ID: <56de959f533f5138f1cd5aaa4706e1831c479e28.1473320411.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove cap-mmc-highspeed property from SDHI2 and SDHI3.

This property is unnecessary as the driver automatically sets
the highspeed capability. Furthermore its use is inconsistent with SDHI0
and SDHI1 which are also highspeed capable but do not have this property
present.

Found by inspection.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 64899b556a0e..8c15040f2540 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -1122,7 +1122,6 @@
 			clocks = <&cpg CPG_MOD 312>;
 			max-frequency = <200000000>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
-			cap-mmc-highspeed;
 			status = "disabled";
 		};
 
@@ -1133,7 +1132,6 @@
 			clocks = <&cpg CPG_MOD 311>;
 			max-frequency = <200000000>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
-			cap-mmc-highspeed;
 			status = "disabled";
 		};
 
-- 
2.7.0.rc3.207.g0ac5344

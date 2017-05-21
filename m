From: ralph.sennhauser@gmail.com (Ralph Sennhauser)
Date: Sun, 21 May 2017 14:48:56 +0200
Subject: [PATCH 07/13] ARM: dts: armada-385-linksys: drop leagcy DSA bindings
In-Reply-To: <20170521124903.11050-1-ralph.sennhauser@gmail.com>
References: <20170521124903.11050-1-ralph.sennhauser@gmail.com>
Message-ID: <20170521124903.11050-8-ralph.sennhauser@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The new ones work so there is little reason to keep the legacy bindings.
Use the rework as the oportunity to drop the legacy node.

Signed-off-by: Ralph Sennhauser <ralph.sennhauser@gmail.com>

---

Notes:

  There is little harm in keeping them but probably no value either, so
  use the cleanup series to get rid of them.
---
 arch/arm/boot/dts/armada-385-linksys.dtsi | 47 -------------------------------
 1 file changed, 47 deletions(-)

diff --git a/arch/arm/boot/dts/armada-385-linksys.dtsi b/arch/arm/boot/dts/armada-385-linksys.dtsi
index 6cc1ec7..f1d6b77 100644
--- a/arch/arm/boot/dts/armada-385-linksys.dtsi
+++ b/arch/arm/boot/dts/armada-385-linksys.dtsi
@@ -115,53 +115,6 @@
 			linux,default-trigger = "disk-activity";
 		};
 	};
-
-	dsa at 0 {
-		status = "disabled";
-
-		compatible = "marvell,dsa";
-		#address-cells = <2>;
-		#size-cells = <0>;
-
-		dsa,ethernet = <&eth2>;
-		dsa,mii-bus = <&mdio>;
-
-		switch at 0 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <0x0 0>;	/* MDIO address 0, switch 0 in tree */
-
-			port at 0 {
-				reg = <0>;
-				label = "lan4";
-			};
-
-			port at 1 {
-				reg = <1>;
-				label = "lan3";
-			};
-
-			port at 2 {
-				reg = <2>;
-				label = "lan2";
-			};
-
-			port at 3 {
-				reg = <3>;
-				label = "lan1";
-			};
-
-			port at 4 {
-				reg = <4>;
-				label = "wan";
-			};
-
-			port at 5 {
-				reg = <5>;
-				label = "cpu";
-			};
-		};
-	};
 };
 
 &ahci0 {
-- 
2.10.2

From: ralph.sennhauser@gmail.com (Ralph Sennhauser)
Date: Thu, 30 Mar 2017 18:54:04 +0200
Subject: [PATCH] ARM: dts: armada-385-linksys: disk-activity trigger for all
Message-ID: <20170330165405.14540-1-ralph.sennhauser@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit a4ee7e18d808 ("ARM: dts: armada: Add default trigger for sata
led") adds the default trigger to individual boards, move it to
armada-385-linksys.dtsi which effectively enables the definition for
the WRT1900ACS (Shelby) as well as for future boards.

Signed-off-by: Ralph Sennhauser <ralph.sennhauser@gmail.com>
---
 arch/arm/boot/dts/armada-385-linksys-caiman.dts | 1 -
 arch/arm/boot/dts/armada-385-linksys-cobra.dts  | 1 -
 arch/arm/boot/dts/armada-385-linksys.dtsi       | 1 +
 3 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/armada-385-linksys-caiman.dts b/arch/arm/boot/dts/armada-385-linksys-caiman.dts
index a1b6e68..f3cee91 100644
--- a/arch/arm/boot/dts/armada-385-linksys-caiman.dts
+++ b/arch/arm/boot/dts/armada-385-linksys-caiman.dts
@@ -109,7 +109,6 @@
 
 		sata {
 			label = "caiman:white:sata";
-			linux,default-trigger = "disk-activity";
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/armada-385-linksys-cobra.dts b/arch/arm/boot/dts/armada-385-linksys-cobra.dts
index a1a75af..1110718 100644
--- a/arch/arm/boot/dts/armada-385-linksys-cobra.dts
+++ b/arch/arm/boot/dts/armada-385-linksys-cobra.dts
@@ -109,7 +109,6 @@
 
 		sata {
 			label = "cobra:white:sata";
-			linux,default-trigger = "disk-activity";
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/armada-385-linksys.dtsi b/arch/arm/boot/dts/armada-385-linksys.dtsi
index aa0d225..2306c45 100644
--- a/arch/arm/boot/dts/armada-385-linksys.dtsi
+++ b/arch/arm/boot/dts/armada-385-linksys.dtsi
@@ -320,6 +320,7 @@
 		sata {
 			gpios = <&gpio1 22 GPIO_ACTIVE_LOW>;
 			default-state = "off";
+			linux,default-trigger = "disk-activity";
 		};
 	};
 
-- 
2.10.2

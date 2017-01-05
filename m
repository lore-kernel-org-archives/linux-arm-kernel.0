From: t.remmet@phytec.de (Teresa Remmet)
Date: Thu, 5 Jan 2017 15:50:46 +0100
Subject: [PATCH 1/6] ARM: dts: am335x-phycore-som: Update NAND partition table
In-Reply-To: <1483627851-17996-1-git-send-email-t.remmet@phytec.de>
References: <1483627851-17996-1-git-send-email-t.remmet@phytec.de>
Message-ID: <1483627851-17996-2-git-send-email-t.remmet@phytec.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To improve NAND safety we updated the partition layout.
Added barebox backup partition and removed kernel and oftree
partition. They are kept in ubi now.

Signed-off-by: Teresa Remmet <t.remmet@phytec.de>
---
 arch/arm/boot/dts/am335x-phycore-som.dtsi | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-phycore-som.dtsi b/arch/arm/boot/dts/am335x-phycore-som.dtsi
index 75e24ad..ef3fe5a 100644
--- a/arch/arm/boot/dts/am335x-phycore-som.dtsi
+++ b/arch/arm/boot/dts/am335x-phycore-som.dtsi
@@ -222,21 +222,19 @@
 			label = "barebox";
 			reg = <0x80000 0x80000>;
 		};
+
 		partition at 5 {
-			label = "bareboxenv";
-			reg = <0x100000 0x40000>;
+			label = "barebox_backup";
+			reg = <0x100000 0x80000>;
 		};
+
 		partition at 6 {
-			label = "oftree";
-			reg = <0x140000 0x40000>;
+			label = "bareboxenv";
+			reg = <0x180000 0x40000>;
 		};
 		partition at 7 {
-			label = "kernel";
-			reg = <0x180000 0x800000>;
-		};
-		partition at 8 {
 			label = "root";
-			reg = <0x980000 0x0>;
+			reg = <0x1C0000 0x0>;
 		};
 	};
 };
-- 
1.9.1

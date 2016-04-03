From: andrew@lunn.ch (Andrew Lunn)
Date: Sun,  3 Apr 2016 04:03:45 +0200
Subject: [PATCH 3/8] ARM: kirkwood: DT: Remove address from dsa unit name
In-Reply-To: <1459649030-21886-1-git-send-email-andrew@lunn.ch>
References: <1459649030-21886-1-git-send-email-andrew@lunn.ch>
Message-ID: <1459649030-21886-4-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dsa node does not have a reg property, so remove the address from
the unit name.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/boot/dts/kirkwood-dir665.dts          | 2 +-
 arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts | 2 +-
 arch/arm/boot/dts/kirkwood-rd88f6281-a.dts     | 2 +-
 arch/arm/boot/dts/kirkwood-rd88f6281-z0.dts    | 2 +-
 arch/arm/boot/dts/kirkwood-rd88f6281.dtsi      | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-dir665.dts b/arch/arm/boot/dts/kirkwood-dir665.dts
index 0473fcc260f7..f548363060ea 100644
--- a/arch/arm/boot/dts/kirkwood-dir665.dts
+++ b/arch/arm/boot/dts/kirkwood-dir665.dts
@@ -203,7 +203,7 @@
 		};
 	};
 
-	dsa at 0 {
+	dsa {
 		compatible = "marvell,dsa";
 		#address-cells = <2>;
 		#size-cells = <0>;
diff --git a/arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts b/arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts
index 6a8f59acb539..26fb610b2af7 100644
--- a/arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts
+++ b/arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts
@@ -121,7 +121,7 @@
 		};
 	};
 
-	dsa at 0 {
+	dsa {
 		compatible = "marvell,dsa";
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/boot/dts/kirkwood-rd88f6281-a.dts b/arch/arm/boot/dts/kirkwood-rd88f6281-a.dts
index f2e08b3b33ea..6f771a99cb02 100644
--- a/arch/arm/boot/dts/kirkwood-rd88f6281-a.dts
+++ b/arch/arm/boot/dts/kirkwood-rd88f6281-a.dts
@@ -19,7 +19,7 @@
 	model = "Marvell RD88f6281 Reference design, with A0 or higher SoC";
 	compatible = "marvell,rd88f6281-a", "marvell,rd88f6281","marvell,kirkwood-88f6281", "marvell,kirkwood";
 
-	dsa at 0 {
+	dsa {
 		switch at 0 {
 			reg = <10 0>;	 /* MDIO address 10, switch 0 in tree */
 		};
diff --git a/arch/arm/boot/dts/kirkwood-rd88f6281-z0.dts b/arch/arm/boot/dts/kirkwood-rd88f6281-z0.dts
index f4272b64ed7f..1a797381d3d4 100644
--- a/arch/arm/boot/dts/kirkwood-rd88f6281-z0.dts
+++ b/arch/arm/boot/dts/kirkwood-rd88f6281-z0.dts
@@ -19,7 +19,7 @@
 	model = "Marvell RD88f6281 Reference design, with Z0 SoC";
 	compatible = "marvell,rd88f6281-z0", "marvell,rd88f6281","marvell,kirkwood-88f6281", "marvell,kirkwood";
 
-	dsa at 0 {
+	dsa {
 		switch at 0 {
 			reg = <0 0>;    /* MDIO address 0, switch 0 in tree */
 			port at 4 {
diff --git a/arch/arm/boot/dts/kirkwood-rd88f6281.dtsi b/arch/arm/boot/dts/kirkwood-rd88f6281.dtsi
index d195e884b3b5..5521426d101b 100644
--- a/arch/arm/boot/dts/kirkwood-rd88f6281.dtsi
+++ b/arch/arm/boot/dts/kirkwood-rd88f6281.dtsi
@@ -63,7 +63,7 @@
 		};
 	};
 
-	dsa at 0 {
+	dsa {
 		compatible = "marvell,dsa";
 		#address-cells = <2>;
 		#size-cells = <0>;
-- 
2.7.0

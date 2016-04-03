From: andrew@lunn.ch (Andrew Lunn)
Date: Sun,  3 Apr 2016 04:03:49 +0200
Subject: [PATCH 7/8] ARM: kirkwood: DT: Add address to mbus unit name
In-Reply-To: <1459649030-21886-1-git-send-email-andrew@lunn.ch>
References: <1459649030-21886-1-git-send-email-andrew@lunn.ch>
Message-ID: <1459649030-21886-8-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mbus node has a ranges property.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/boot/dts/kirkwood-6192.dtsi     | 2 +-
 arch/arm/boot/dts/kirkwood-6281.dtsi     | 2 +-
 arch/arm/boot/dts/kirkwood-6282.dtsi     | 2 +-
 arch/arm/boot/dts/kirkwood-98dx4122.dtsi | 2 +-
 arch/arm/boot/dts/kirkwood.dtsi          | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-6192.dtsi b/arch/arm/boot/dts/kirkwood-6192.dtsi
index 1014a5dd9035..d573e03f3134 100644
--- a/arch/arm/boot/dts/kirkwood-6192.dtsi
+++ b/arch/arm/boot/dts/kirkwood-6192.dtsi
@@ -1,5 +1,5 @@
 / {
-	mbus {
+	mbus at f1000000 {
 		pciec: pcie-controller at 82000000 {
 			compatible = "marvell,kirkwood-pcie";
 			status = "disabled";
diff --git a/arch/arm/boot/dts/kirkwood-6281.dtsi b/arch/arm/boot/dts/kirkwood-6281.dtsi
index fad201551304..748d0b62f233 100644
--- a/arch/arm/boot/dts/kirkwood-6281.dtsi
+++ b/arch/arm/boot/dts/kirkwood-6281.dtsi
@@ -1,5 +1,5 @@
 / {
-	mbus {
+	mbus at f1000000 {
 		pciec: pcie-controller at 82000000 {
 			compatible = "marvell,kirkwood-pcie";
 			status = "disabled";
diff --git a/arch/arm/boot/dts/kirkwood-6282.dtsi b/arch/arm/boot/dts/kirkwood-6282.dtsi
index 27434c35eb66..bb63d2d50fc5 100644
--- a/arch/arm/boot/dts/kirkwood-6282.dtsi
+++ b/arch/arm/boot/dts/kirkwood-6282.dtsi
@@ -1,5 +1,5 @@
 / {
-	mbus {
+	mbus at f1000000 {
 		pciec: pcie-controller at 82000000 {
 			compatible = "marvell,kirkwood-pcie";
 			status = "disabled";
diff --git a/arch/arm/boot/dts/kirkwood-98dx4122.dtsi b/arch/arm/boot/dts/kirkwood-98dx4122.dtsi
index 17eb92733310..720c210d491d 100644
--- a/arch/arm/boot/dts/kirkwood-98dx4122.dtsi
+++ b/arch/arm/boot/dts/kirkwood-98dx4122.dtsi
@@ -1,5 +1,5 @@
 / {
-	mbus {
+	mbus at f1000000 {
 		pciec: pcie-controller at 82000000 {
 			compatible = "marvell,kirkwood-pcie";
 			status = "disabled";
diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
index 7445a15e259d..29b8bd7e0d93 100644
--- a/arch/arm/boot/dts/kirkwood.dtsi
+++ b/arch/arm/boot/dts/kirkwood.dtsi
@@ -27,7 +27,7 @@
 	       i2c0 = &i2c0;
 	};
 
-	mbus {
+	mbus at f1000000 {
 		compatible = "marvell,kirkwood-mbus", "simple-bus";
 		#address-cells = <2>;
 		#size-cells = <1>;
-- 
2.7.0

From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue,  3 Mar 2015 15:41:01 +0100
Subject: [PATCH v3 06/20] ARM: mvebu: add serial port aliases on Armada
 370/375/38x/XP
In-Reply-To: <1425393675-17820-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1425393675-17820-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1425393675-17820-7-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds 'serialX' aliases for the various serial ports on
Armada 370, 375, 38x and XP platforms. It will allow the usage of the
stdout-path property.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-xp.dtsi | 2 ++
 arch/arm/boot/dts/armada-375.dtsi    | 2 ++
 arch/arm/boot/dts/armada-38x.dtsi    | 2 ++
 arch/arm/boot/dts/armada-xp.dtsi     | 2 ++
 4 files changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
index d36b1e5..1058cf6 100644
--- a/arch/arm/boot/dts/armada-370-xp.dtsi
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@ -59,6 +59,8 @@
 	compatible = "marvell,armada-370-xp";
 
 	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
 	};
 
 	cpus {
diff --git a/arch/arm/boot/dts/armada-375.dtsi b/arch/arm/boot/dts/armada-375.dtsi
index 0d02251..6420693 100644
--- a/arch/arm/boot/dts/armada-375.dtsi
+++ b/arch/arm/boot/dts/armada-375.dtsi
@@ -60,6 +60,8 @@
 		gpio0 = &gpio0;
 		gpio1 = &gpio1;
 		gpio2 = &gpio2;
+		serial0 = &uart0;
+		serial1 = &uart1;
 	};
 
 	clocks {
diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
index 044e83c..7cf6657 100644
--- a/arch/arm/boot/dts/armada-38x.dtsi
+++ b/arch/arm/boot/dts/armada-38x.dtsi
@@ -59,6 +59,8 @@
 	aliases {
 		gpio0 = &gpio0;
 		gpio1 = &gpio1;
+		serial0 = &uart0;
+		serial1 = &uart1;
 	};
 
 	soc {
diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
index 975ae64..bbabee5 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -57,6 +57,8 @@
 	compatible = "marvell,armadaxp", "marvell,armada-370-xp";
 
 	aliases {
+		serial2 = &uart2;
+		serial3 = &uart3;
 	};
 
 	soc {
-- 
2.1.0

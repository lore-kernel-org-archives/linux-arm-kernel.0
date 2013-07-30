From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 30 Jul 2013 16:59:02 +0200
Subject: [PATCH] ARM: mvebu: use correct #interrupt-cells instead of
 #interrupts-cells
Message-ID: <1375196342-30286-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Device Tree information for the GPIO banks of the Armada 370 and
Armada XP SOCs was incorrectly using #interrupts-cells instead of
controller when using GPIO interrupts, since the GPIO bank DT node
wasn't recognized as a valid interrupt controller by the OF code.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
Note: until now, this wasn't causing any problem since no board was
using Device Tree based GPIO interrupts.
---
 arch/arm/boot/dts/armada-370.dtsi        | 6 +++---
 arch/arm/boot/dts/armada-xp-mv78230.dtsi | 4 ++--
 arch/arm/boot/dts/armada-xp-mv78260.dtsi | 6 +++---
 arch/arm/boot/dts/armada-xp-mv78460.dtsi | 6 +++---
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
index fa3dfc6..e8deeab 100644
--- a/arch/arm/boot/dts/armada-370.dtsi
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -78,7 +78,7 @@
 				gpio-controller;
 				#gpio-cells = <2>;
 				interrupt-controller;
-				#interrupts-cells = <2>;
+				#interrupt-cells = <2>;
 				interrupts = <82>, <83>, <84>, <85>;
 			};
 
@@ -89,7 +89,7 @@
 				gpio-controller;
 				#gpio-cells = <2>;
 				interrupt-controller;
-				#interrupts-cells = <2>;
+				#interrupt-cells = <2>;
 				interrupts = <87>, <88>, <89>, <90>;
 			};
 
@@ -100,7 +100,7 @@
 				gpio-controller;
 				#gpio-cells = <2>;
 				interrupt-controller;
-				#interrupts-cells = <2>;
+				#interrupt-cells = <2>;
 				interrupts = <91>;
 			};
 
diff --git a/arch/arm/boot/dts/armada-xp-mv78230.dtsi b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
index f8eaa38..ab40f96 100644
--- a/arch/arm/boot/dts/armada-xp-mv78230.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
@@ -63,7 +63,7 @@
 				gpio-controller;
 				#gpio-cells = <2>;
 				interrupt-controller;
-				#interrupts-cells = <2>;
+				#interrupt-cells = <2>;
 				interrupts = <82>, <83>, <84>, <85>;
 			};
 
@@ -74,7 +74,7 @@
 				gpio-controller;
 				#gpio-cells = <2>;
 				interrupt-controller;
-				#interrupts-cells = <2>;
+				#interrupt-cells = <2>;
 				interrupts = <87>, <88>, <89>;
 			};
 
diff --git a/arch/arm/boot/dts/armada-xp-mv78260.dtsi b/arch/arm/boot/dts/armada-xp-mv78260.dtsi
index 2d9335d..254bd24 100644
--- a/arch/arm/boot/dts/armada-xp-mv78260.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78260.dtsi
@@ -64,7 +64,7 @@
 				gpio-controller;
 				#gpio-cells = <2>;
 				interrupt-controller;
-				#interrupts-cells = <2>;
+				#interrupt-cells = <2>;
 				interrupts = <82>, <83>, <84>, <85>;
 			};
 
@@ -75,7 +75,7 @@
 				gpio-controller;
 				#gpio-cells = <2>;
 				interrupt-controller;
-				#interrupts-cells = <2>;
+				#interrupt-cells = <2>;
 				interrupts = <87>, <88>, <89>, <90>;
 			};
 
@@ -86,7 +86,7 @@
 				gpio-controller;
 				#gpio-cells = <2>;
 				interrupt-controller;
-				#interrupts-cells = <2>;
+				#interrupt-cells = <2>;
 				interrupts = <91>;
 			};
 
diff --git a/arch/arm/boot/dts/armada-xp-mv78460.dtsi b/arch/arm/boot/dts/armada-xp-mv78460.dtsi
index c7b1f4d..9bb9620 100644
--- a/arch/arm/boot/dts/armada-xp-mv78460.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78460.dtsi
@@ -80,7 +80,7 @@
 				gpio-controller;
 				#gpio-cells = <2>;
 				interrupt-controller;
-				#interrupts-cells = <2>;
+				#interrupt-cells = <2>;
 				interrupts = <82>, <83>, <84>, <85>;
 			};
 
@@ -91,7 +91,7 @@
 				gpio-controller;
 				#gpio-cells = <2>;
 				interrupt-controller;
-				#interrupts-cells = <2>;
+				#interrupt-cells = <2>;
 				interrupts = <87>, <88>, <89>, <90>;
 			};
 
@@ -102,7 +102,7 @@
 				gpio-controller;
 				#gpio-cells = <2>;
 				interrupt-controller;
-				#interrupts-cells = <2>;
+				#interrupt-cells = <2>;
 				interrupts = <91>;
 			};
 
-- 
1.8.1.2

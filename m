From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri,  4 Jan 2013 17:04:57 +0100
Subject: [PATCH 3/4] arm: mvebu: Armada XP MV78230 has only three Ethernet
 interfaces
In-Reply-To: <1357315498-4570-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1357315498-4570-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1357315498-4570-4-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We originally thought that the MV78230 variant of the Armada XP had
four Ethernet interfaces, like the other variants MV78260 and
MV78460. In fact, this is not true, and the MV78230 has only three
Ethernet interfaces.

So, the definitions of the Ethernet interfaces is now done as follows:

 * armada-370-xp.dtsi: definitions of the first two interfaces, that
   are common to Armada 370 and Armada XP

 * armada-xp.dtsi: definition of the third interface, common to all
   Armada XP variants.

 * armada-xp-mv78260.dtsi and armada-xp-mv78460.dtsi: definition of
   the fourth interface.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
This is a fix for 3.8, should be pushed for some 3.8-rc.
---
 arch/arm/boot/dts/armada-xp-mv78260.dtsi |    8 ++++++++
 arch/arm/boot/dts/armada-xp-mv78460.dtsi |    8 ++++++++
 arch/arm/boot/dts/armada-xp.dtsi         |    8 --------
 3 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/armada-xp-mv78260.dtsi b/arch/arm/boot/dts/armada-xp-mv78260.dtsi
index a2aee57..1c1937d 100644
--- a/arch/arm/boot/dts/armada-xp-mv78260.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78260.dtsi
@@ -85,5 +85,13 @@
 			#interrupts-cells = <2>;
 			interrupts = <24>;
 		};
+
+		ethernet at d0034000 {
+				compatible = "marvell,armada-370-neta";
+				reg = <0xd0034000 0x2500>;
+				interrupts = <14>;
+				clocks = <&gateclk 1>;
+				status = "disabled";
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/armada-xp-mv78460.dtsi b/arch/arm/boot/dts/armada-xp-mv78460.dtsi
index da03a12..4905cf3 100644
--- a/arch/arm/boot/dts/armada-xp-mv78460.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78460.dtsi
@@ -100,5 +100,13 @@
 			#interrupts-cells = <2>;
 			interrupts = <24>;
 		};
+
+		ethernet at d0034000 {
+				compatible = "marvell,armada-370-neta";
+				reg = <0xd0034000 0x2500>;
+				interrupts = <14>;
+				clocks = <&gateclk 1>;
+				status = "disabled";
+		};
 	};
  };
diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
index 5996c69..390ba98 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -95,14 +95,6 @@
 				status = "disabled";
 		};
 
-		ethernet at d0034000 {
-				compatible = "marvell,armada-370-neta";
-				reg = <0xd0034000 0x2500>;
-				interrupts = <14>;
-				clocks = <&gateclk 1>;
-				status = "disabled";
-		};
-
 		xor at d0060900 {
 			compatible = "marvell,orion-xor";
 			reg = <0xd0060900 0x100
-- 
1.7.9.5

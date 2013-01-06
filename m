From: andrew@lunn.ch (Andrew Lunn)
Date: Sun,  6 Jan 2013 11:10:41 +0100
Subject: [PATCH 08/11] arm: mvebu: Armada XP MV78230 has only three Ethernet
 interfaces
In-Reply-To: <1357467044-4914-1-git-send-email-andrew@lunn.ch>
References: <1357467044-4914-1-git-send-email-andrew@lunn.ch>
Message-ID: <1357467044-4914-9-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

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
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
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
index 367aa3f..2a98e12 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -93,14 +93,6 @@
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
1.7.10.4

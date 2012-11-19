From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 19 Nov 2012 15:27:00 +0100
Subject: [PATCH 1/2] arm: mvebu: add 'clocks' property to Ethernet nodes for
 Armada 370/XP SoCs
In-Reply-To: <1353335221-26516-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1353335221-26516-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1353335221-26516-2-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mvneta driver now understands a standard 'clocks' clock pointer
property in the Device Tree nodes for the Ethernet devices, so we add
the right clock reference for the different Ethernet ports of the
Armada 370/XP SoCs.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-xp.dtsi |    2 ++
 arch/arm/boot/dts/armada-xp.dtsi     |    2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
index 08ec354..ee71143c 100644
--- a/arch/arm/boot/dts/armada-370-xp.dtsi
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@ -109,6 +109,7 @@
 				compatible = "marvell,armada-370-neta";
 				reg = <0xd0070000 0x2500>;
 				interrupts = <8>;
+				clocks = <&gateclk 4>;
 				status = "disabled";
 		};
 
@@ -116,6 +117,7 @@
 				compatible = "marvell,armada-370-neta";
 				reg = <0xd0074000 0x2500>;
 				interrupts = <10>;
+				clocks = <&gateclk 3>;
 				status = "disabled";
 		};
 
diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
index 84cb87d..8e39cb7 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -112,6 +112,7 @@
 				compatible = "marvell,armada-370-neta";
 				reg = <0xd0030000 0x2500>;
 				interrupts = <12>;
+				clocks = <&gateclk 2>;
 				status = "disabled";
 		};
 
@@ -119,6 +120,7 @@
 				compatible = "marvell,armada-370-neta";
 				reg = <0xd0034000 0x2500>;
 				interrupts = <14>;
+				clocks = <&gateclk 1>;
 				status = "disabled";
 		};
 	};
-- 
1.7.9.5

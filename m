From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu,  6 Mar 2014 17:46:34 +0100
Subject: [PATCH 09/10] ARM: mvebu: enable the coherency fabric on Armada 375
In-Reply-To: <1394124395-20030-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1394124395-20030-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1394124395-20030-10-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds the necessary Device Tree information to enable the
coherency fabric on Armada 375.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-375.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/armada-375.dtsi b/arch/arm/boot/dts/armada-375.dtsi
index 3877693..eceab89 100644
--- a/arch/arm/boot/dts/armada-375.dtsi
+++ b/arch/arm/boot/dts/armada-375.dtsi
@@ -128,6 +128,11 @@
 				cache-level = <2>;
 			};
 
+			scu at c000 {
+				compatible = "arm,cortex-a9-scu";
+				reg = <0xc000 0x58>;
+			};
+
 			timer at c600 {
 				compatible = "arm,cortex-a9-twd-timer";
 				reg = <0xc600 0x20>;
@@ -320,6 +325,11 @@
 				clocks = <&coreclk 0>;
 			};
 
+			coherency-fabric at 21010 {
+				compatible = "marvell,armada-375-coherency-fabric";
+				reg = <0x21010 0x1c>;
+			};
+
 			xor at 60800 {
 				compatible = "marvell,orion-xor";
 				reg = <0x60800 0x100
-- 
1.8.3.2

From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu,  6 Mar 2014 17:46:35 +0100
Subject: [PATCH 10/10] ARM: mvebu: enable the coherency fabric on Armada 38x
In-Reply-To: <1394124395-20030-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1394124395-20030-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1394124395-20030-11-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds the necessary Device Tree information to enable the
coherency fabric on Armada 38x.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-38x.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
index 812ce28..2332b20 100644
--- a/arch/arm/boot/dts/armada-38x.dtsi
+++ b/arch/arm/boot/dts/armada-38x.dtsi
@@ -108,6 +108,11 @@
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
@@ -267,6 +272,11 @@
 				clock-names = "nbclk", "fixed";
 			};
 
+			coherency-fabric at 21010 {
+				compatible = "marvell,armada-380-coherency-fabric";
+				reg = <0x21010 0x1c>;
+			};
+
 			eth1: ethernet at 30000 {
 				compatible = "marvell,armada-370-neta";
 				reg = <0x30000 0x4000>;
-- 
1.8.3.2

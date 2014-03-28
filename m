From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 28 Mar 2014 14:07:06 +0100
Subject: [PATCH 10/10] ARM: mvebu: add SMP support in the Armada 38x device
 tree
In-Reply-To: <1396012026-5997-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1396012026-5997-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1396012026-5997-11-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit improves the Armada 38x Device Tree to add the CPU reset
and PMSU Device Tree nodes, which are necessary to get SMP working.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-38x.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
index 2332b20..2b2145e 100644
--- a/arch/arm/boot/dts/armada-38x.dtsi
+++ b/arch/arm/boot/dts/armada-38x.dtsi
@@ -272,11 +272,21 @@
 				clock-names = "nbclk", "fixed";
 			};
 
+			cpurst at 20800 {
+				compatible = "marvell,armada-380-cpu-reset";
+				reg = <0x20800 0x10>;
+			};
+
 			coherency-fabric at 21010 {
 				compatible = "marvell,armada-380-coherency-fabric";
 				reg = <0x21010 0x1c>;
 			};
 
+			pmsu at 22000 {
+				compatible = "marvell,armada-380-pmsu";
+				reg = <0x22000 0x1000>;
+			};
+
 			eth1: ethernet at 30000 {
 				compatible = "marvell,armada-370-neta";
 				reg = <0x30000 0x4000>;
-- 
1.8.3.2

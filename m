From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 28 Mar 2014 14:07:05 +0100
Subject: [PATCH 09/10] ARM: mvebu: add SMP support in the Armada 375 device
 tree
In-Reply-To: <1396012026-5997-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1396012026-5997-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1396012026-5997-10-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gregory CLEMENT <gregory.clement@free-electrons.com>

Improve the Armada 375 Device Tree to add the CPU reset Device Tree
node, which is necessary to get SMP working.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-375.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/armada-375.dtsi b/arch/arm/boot/dts/armada-375.dtsi
index eceab89..b9b901d 100644
--- a/arch/arm/boot/dts/armada-375.dtsi
+++ b/arch/arm/boot/dts/armada-375.dtsi
@@ -325,6 +325,11 @@
 				clocks = <&coreclk 0>;
 			};
 
+			cpurst at 20800 {
+				compatible = "marvell,armada-375-cpu-reset";
+				reg = <0x20800 0x10>;
+			};
+
 			coherency-fabric at 21010 {
 				compatible = "marvell,armada-375-coherency-fabric";
 				reg = <0x21010 0x1c>;
-- 
1.8.3.2

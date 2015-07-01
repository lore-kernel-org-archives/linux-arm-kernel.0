From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed,  1 Jul 2015 13:36:02 +0100
Subject: [PATCH 2/3] arm: dts: vexpress: add missing CCI PMU device node to TC2
In-Reply-To: <1435754163-17929-1-git-send-email-sudeep.holla@arm.com>
References: <1435754163-17929-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1435754163-17929-3-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CCI device node was added to vexpress CA15_A7(i.e. TC2) much before
the CCI PMU support and binding was added. This patch adds the missing
PMU node so that CCI PMUs can be used on TC2.

Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Acked-by: Punit Agrawal <punit.agrawal@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
index 038e30e4332f..17f63f7dfd9e 100644
--- a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
+++ b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
@@ -150,6 +150,16 @@
 			interface-type = "ace";
 			reg = <0x5000 0x1000>;
 		};
+
+		pmu at 9000 {
+			 compatible = "arm,cci-400-pmu,r0";
+			 reg = <0x9000 0x5000>;
+			 interrupts = <0 105 4>,
+				      <0 101 4>,
+				      <0 102 4>,
+				      <0 103 4>,
+				      <0 104 4>;
+		};
 	};
 
 	memory-controller at 7ffd0000 {
-- 
1.9.1

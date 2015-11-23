From: juri.lelli@arm.com (Juri Lelli)
Date: Mon, 23 Nov 2015 14:28:37 +0000
Subject: [RFC PATCH 4/8] arm, dts: add TC2 cpu capacity information
In-Reply-To: <1448288921-30307-1-git-send-email-juri.lelli@arm.com>
References: <1448288921-30307-1-git-send-email-juri.lelli@arm.com>
Message-ID: <1448288921-30307-5-git-send-email-juri.lelli@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add TC2 cpu capacity binding information.

Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Kumar Gala <galak@codeaurora.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: devicetree at vger.kernel.org
Signed-off-by: Juri Lelli <juri.lelli@arm.com>
---
 arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
index 17f63f7..4596481 100644
--- a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
+++ b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
@@ -32,6 +32,7 @@
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
+		capacity-scale = <1024>;
 
 		cpu0: cpu at 0 {
 			device_type = "cpu";
@@ -39,6 +40,7 @@
 			reg = <0>;
 			cci-control-port = <&cci_control1>;
 			cpu-idle-states = <&CLUSTER_SLEEP_BIG>;
+			capacity = <1024>;
 		};
 
 		cpu1: cpu at 1 {
@@ -47,6 +49,7 @@
 			reg = <1>;
 			cci-control-port = <&cci_control1>;
 			cpu-idle-states = <&CLUSTER_SLEEP_BIG>;
+			capacity = <1024>;
 		};
 
 		cpu2: cpu at 2 {
@@ -55,6 +58,7 @@
 			reg = <0x100>;
 			cci-control-port = <&cci_control2>;
 			cpu-idle-states = <&CLUSTER_SLEEP_LITTLE>;
+			capacity = <430>;
 		};
 
 		cpu3: cpu at 3 {
@@ -63,6 +67,7 @@
 			reg = <0x101>;
 			cci-control-port = <&cci_control2>;
 			cpu-idle-states = <&CLUSTER_SLEEP_LITTLE>;
+			capacity = <430>;
 		};
 
 		cpu4: cpu at 4 {
@@ -71,6 +76,7 @@
 			reg = <0x102>;
 			cci-control-port = <&cci_control2>;
 			cpu-idle-states = <&CLUSTER_SLEEP_LITTLE>;
+			capacity = <430>;
 		};
 
 		idle-states {
-- 
2.2.2

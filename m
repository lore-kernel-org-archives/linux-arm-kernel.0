From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 22 Apr 2013 16:27:31 +0100
Subject: [RFC PATCH v2 09/13] ARM: mach-shmobile: cpus/cpu nodes dts updates
In-Reply-To: <1366644455-16550-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1366644455-16550-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1366644455-16550-10-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates the in-kernel dts files according to the latest cpus
and cpu bindings updates for ARM.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm/boot/dts/r8a7740.dtsi | 3 +++
 arch/arm/boot/dts/sh7372.dtsi  | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
index 798fa35..b47bb36 100644
--- a/arch/arm/boot/dts/r8a7740.dtsi
+++ b/arch/arm/boot/dts/r8a7740.dtsi
@@ -14,8 +14,11 @@
 	compatible = "renesas,r8a7740";
 
 	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
 		cpu at 0 {
 			compatible = "arm,cortex-a9";
+			reg = <0x0>;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/sh7372.dtsi b/arch/arm/boot/dts/sh7372.dtsi
index 677fc60..78478af 100644
--- a/arch/arm/boot/dts/sh7372.dtsi
+++ b/arch/arm/boot/dts/sh7372.dtsi
@@ -14,8 +14,12 @@
 	compatible = "renesas,sh7372";
 
 	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
 		cpu at 0 {
 			compatible = "arm,cortex-a8";
+			reg = <0x0>;
 		};
 	};
 };
-- 
1.7.12

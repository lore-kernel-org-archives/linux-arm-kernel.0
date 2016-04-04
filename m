From: j-keerthy@ti.com (Keerthy)
Date: Mon, 4 Apr 2016 23:59:02 +0530
Subject: [PATCH 1/2] keystone: dts: add psci command definition
In-Reply-To: <1459794543-4822-1-git-send-email-j-keerthy@ti.com>
References: <1459794543-4822-1-git-send-email-j-keerthy@ti.com>
Message-ID: <1459794543-4822-2-git-send-email-j-keerthy@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vitaly Andrianov <vitalya@ti.com> 

This commit adds definition for cpu_on, cpu_off and cpu_suspend commands.
These definitions must match the corresponding PSCI definitions in
boot monitor.

Having those command and corresponding PSCI support in boot monitor allows
run time CPU hot plugin.

Signed-off-by: Vitaly Andrianov <vitalya@ti.com>
Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm/boot/dts/keystone.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/keystone.dtsi b/arch/arm/boot/dts/keystone.dtsi
index 3f27282..0076489 100644
--- a/arch/arm/boot/dts/keystone.dtsi
+++ b/arch/arm/boot/dts/keystone.dtsi
@@ -59,6 +59,14 @@
 			     <GIC_SPI 23 IRQ_TYPE_EDGE_RISING>;
 	};
 
+	psci {
+		compatible	= "arm,psci";
+		method		= "smc";
+		cpu_suspend	= <0x84000001>;
+		cpu_off		= <0x84000002>;
+		cpu_on		= <0x84000003>;
+	};
+
 	soc {
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
1.9.1

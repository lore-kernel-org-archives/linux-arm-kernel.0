From: vitalya@ti.com (Vitaly Andrianov)
Date: Wed, 1 Jul 2015 08:13:04 -0400
Subject: [PATCH] keystone: dts: add psci command definition
In-Reply-To: <1435752784-30639-1-git-send-email-vitalya@ti.com>
References: <1435752784-30639-1-git-send-email-vitalya@ti.com>
Message-ID: <1435752784-30639-2-git-send-email-vitalya@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds definition for cpu_on, cpu_off and cpu_suspend commands.
These definitions must match the corresponding PSCI definitions in
boot monitor.

Signed-off-by: Vitaly Andrianov <vitalya@ti.com>
---
 arch/arm/boot/dts/keystone.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/keystone.dtsi b/arch/arm/boot/dts/keystone.dtsi
index c06542b..ab60fca 100644
--- a/arch/arm/boot/dts/keystone.dtsi
+++ b/arch/arm/boot/dts/keystone.dtsi
@@ -58,6 +58,14 @@
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

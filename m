From: robherring2@gmail.com (Rob Herring)
Date: Sun, 28 Jul 2013 16:56:38 -0500
Subject: [PATCH 7/7] dts: calxeda: add ARM PSCI binding
In-Reply-To: <1375048598-15637-1-git-send-email-robherring2@gmail.com>
References: <1375048598-15637-1-git-send-email-robherring2@gmail.com>
Message-ID: <1375048598-15637-8-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Add the PSCI binding for Calxeda SOCs. The PSCI function numbers are
different from the DT binding example because the numbering changed in
revisions of the PSCI spec and are already fixed in highbank firmware.
Since the numbering is transparent to the kernel, this difference is not
significant.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/boot/dts/ecx-common.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/ecx-common.dtsi b/arch/arm/boot/dts/ecx-common.dtsi
index e8559b7..f1dfc09 100644
--- a/arch/arm/boot/dts/ecx-common.dtsi
+++ b/arch/arm/boot/dts/ecx-common.dtsi
@@ -19,6 +19,16 @@
 		bootargs = "console=ttyAMA0";
 	};
 
+	psci {
+		compatible	= "arm,psci";
+		method		= "smc";
+		cpu_suspend	= <0x84000002>;
+		cpu_off		= <0x84000004>;
+		cpu_on		= <0x84000006>;
+		system_off	= <0x84000100>;
+		system_reset	= <0x84000101>;
+	};
+
 	soc {
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
1.8.1.2

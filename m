From: robherring2@gmail.com (Rob Herring)
Date: Tue, 26 Feb 2013 21:42:06 -0600
Subject: [PATCH 2/4] dts: calxeda: add ARM PSCI binding
In-Reply-To: <1361936528-25998-1-git-send-email-robherring2@gmail.com>
References: <1361936528-25998-1-git-send-email-robherring2@gmail.com>
Message-ID: <1361936528-25998-3-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Add the PSCI binding for Calxeda SOCs.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/boot/dts/ecx-common.dtsi |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/ecx-common.dtsi b/arch/arm/boot/dts/ecx-common.dtsi
index d61b535..2c7b31e 100644
--- a/arch/arm/boot/dts/ecx-common.dtsi
+++ b/arch/arm/boot/dts/ecx-common.dtsi
@@ -19,6 +19,14 @@
 		bootargs = "console=ttyAMA0";
 	};
 
+	psci {
+		compatible	= "arm,psci";
+		method		= "smc";
+		cpu_suspend	= <0x95c10000>;
+		cpu_off		= <0x95c10001>;
+		cpu_on		= <0x95c10002>;
+	};
+
 	soc {
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
1.7.10.4

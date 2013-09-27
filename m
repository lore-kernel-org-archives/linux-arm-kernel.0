From: robherring2@gmail.com (Rob Herring)
Date: Thu, 26 Sep 2013 21:24:54 -0500
Subject: [PATCH 6/6] dts: calxeda: add ARM PSCI binding
In-Reply-To: <1380248694-13388-1-git-send-email-robherring2@gmail.com>
References: <1380248694-13388-1-git-send-email-robherring2@gmail.com>
Message-ID: <1380248694-13388-7-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Add the PSCI binding node for Calxeda SOCs. Only claiming "arm,psci"
support since there is no agreement on 0.2 binding definition.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: devicetree at vger.kernel.org
---
 arch/arm/boot/dts/ecx-common.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/ecx-common.dtsi b/arch/arm/boot/dts/ecx-common.dtsi
index e8559b7..bc22557 100644
--- a/arch/arm/boot/dts/ecx-common.dtsi
+++ b/arch/arm/boot/dts/ecx-common.dtsi
@@ -19,6 +19,14 @@
 		bootargs = "console=ttyAMA0";
 	};
 
+	psci {
+		compatible	= "arm,psci";
+		method		= "smc";
+		cpu_suspend	= <0x84000002>;
+		cpu_off		= <0x84000004>;
+		cpu_on		= <0x84000006>;
+	};
+
 	soc {
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
1.8.1.2

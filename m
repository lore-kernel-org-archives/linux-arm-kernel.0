From: German.Rivera@freescale.com (J. German Rivera)
Date: Fri, 23 Oct 2015 20:31:20 -0500
Subject: [PATCH] arm64: dts: Added syscon-reboot node for FSL's LS2085A SoC
Message-ID: <1445650280-9966-1-git-send-email-German.Rivera@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Added sys-reboot node to the FSL's LS2085A SoC DT to leverage
the ARM-generic reboot mechanism for this SoC. This mechanism
is enabled through CONFIG_POWER_RESET_SYSCON.

Signed-off-by: J. German Rivera <German.Rivera@freescale.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls2085a.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2085a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls2085a.dtsi
index e281ceb..6f82163 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls2085a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls2085a.dtsi
@@ -131,6 +131,18 @@
 		interrupts = <1 9 0x4>;
 	};
 
+	rst_ccsr: rstccsr at 1E60000 {
+	        compatible = "syscon";
+		reg = <0x0 0x1E60000 0x0 0x10000>;
+	};
+
+	reboot at 65024000 {
+		compatible ="syscon-reboot";
+		regmap = <&rst_ccsr>;
+		offset = <0x0>;
+		mask = <0x2>;
+	};
+
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <1 13 0x8>, /* Physical Secure PPI, active-low */
-- 
2.3.3

From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 25 Nov 2014 16:25:03 +0000
Subject: [PATCH v2 6/8] ARM: STi: STiH407: Enable Cortex-A9 PMU support
In-Reply-To: <1416932705-16880-1-git-send-email-lee.jones@linaro.org>
References: <1416932705-16880-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1416932705-16880-7-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is ARM's generic Performance Monitoring Unit.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih407.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/stih407.dtsi b/arch/arm/boot/dts/stih407.dtsi
index 4f9024f..53bfcd9 100644
--- a/arch/arm/boot/dts/stih407.dtsi
+++ b/arch/arm/boot/dts/stih407.dtsi
@@ -56,6 +56,12 @@
 		cache-level = <2>;
 	};
 
+	arm-pmu {
+		interrupt-parent = <&intc>;
+		compatible = "arm,cortex-a9-pmu";
+		interrupts = <GIC_PPI 15 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
 	soc {
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
1.9.1

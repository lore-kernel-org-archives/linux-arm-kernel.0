From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 12 May 2015 13:51:48 +0100
Subject: [PATCH 11/13] ARM: STi: STiH407: Enable Cortex-A9 PMU support
In-Reply-To: <1431435110-22595-1-git-send-email-lee.jones@linaro.org>
References: <1431435110-22595-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1431435110-22595-12-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is ARM's generic Performance Monitoring Unit.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih407-family.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
index 46e6a38..412206e 100644
--- a/arch/arm/boot/dts/stih407-family.dtsi
+++ b/arch/arm/boot/dts/stih407-family.dtsi
@@ -58,6 +58,12 @@
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

From: vkale@apm.com (Vinayak Kale)
Date: Thu, 20 Mar 2014 15:17:27 +0530
Subject: [PATCH 2/2] arm64: dts: Add PMU node for APM X-Gene Storm SOC
In-Reply-To: <1395308847-16317-1-git-send-email-vkale@apm.com>
References: <1395308847-16317-1-git-send-email-vkale@apm.com>
Message-ID: <1395308847-16317-3-git-send-email-vkale@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the PMU device tree node for APM X-Gene Storm SOC.

Please note that this patch has dependancy on a GIC driver patch [1] which is
yet to be approved by maintainers.

[1]- https://lkml.org/lkml/2014/2/27/605
(irqchip:gic: change access of gicc_ctrl register to read modify write)

Signed-off-by: Vinayak Kale <vkale@apm.com>
---
 arch/arm64/boot/dts/apm-storm.dtsi |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/apm-storm.dtsi b/arch/arm64/boot/dts/apm-storm.dtsi
index d37d736..5edb16a 100644
--- a/arch/arm64/boot/dts/apm-storm.dtsi
+++ b/arch/arm64/boot/dts/apm-storm.dtsi
@@ -97,6 +97,11 @@
 		clock-frequency = <50000000>;
 	};
 
+	pmu {
+		compatible = "apm,potenza-pmu", "arm,armv8-pmuv3";
+		interrupts = <1 12 0xff04>;
+	};
+
 	soc {
 		compatible = "simple-bus";
 		#address-cells = <2>;
-- 
1.7.9.5

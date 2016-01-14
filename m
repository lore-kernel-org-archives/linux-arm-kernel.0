From: jan.glauber@gmail.com (Jan Glauber)
Date: Thu, 14 Jan 2016 13:55:43 +0100
Subject: [RFC PATCH 3/5] arm64: dts: Add Cavium ThunderX specific PMU
In-Reply-To: <cover.1452766568.git.jglauber@cavium.com>
References: <cover.1452766568.git.jglauber@cavium.com>
Message-ID: <9b05a1866d37f3c1af0c6ae5835df810342ff558.1452766568.git.jglauber@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a compatible string for the Cavium ThunderX PMU.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 Documentation/devicetree/bindings/arm/pmu.txt | 1 +
 arch/arm64/boot/dts/cavium/thunder-88xx.dtsi  | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/pmu.txt b/Documentation/devicetree/bindings/arm/pmu.txt
index 5651883..9bd0a33 100644
--- a/Documentation/devicetree/bindings/arm/pmu.txt
+++ b/Documentation/devicetree/bindings/arm/pmu.txt
@@ -25,6 +25,7 @@ Required properties:
 	"qcom,scorpion-pmu"
 	"qcom,scorpion-mp-pmu"
 	"qcom,krait-pmu"
+	"cavium,thunderx-pmu"
 - interrupts : 1 combined interrupt or 1 per core. If the interrupt is a per-cpu
                interrupt (PPI) then 1 interrupt should be specified.
 
diff --git a/arch/arm64/boot/dts/cavium/thunder-88xx.dtsi b/arch/arm64/boot/dts/cavium/thunder-88xx.dtsi
index 9cb7cf9..84ac556 100644
--- a/arch/arm64/boot/dts/cavium/thunder-88xx.dtsi
+++ b/arch/arm64/boot/dts/cavium/thunder-88xx.dtsi
@@ -360,6 +360,11 @@
 		             <1 10 0xff01>;
 	};
 
+	pmu {
+		compatible = "cavium,thunderx-pmu", "arm,armv8-pmuv3";
+		interrupts = <1 7 4>;
+	};
+
 	soc {
 		compatible = "simple-bus";
 		#address-cells = <2>;
-- 
1.9.1

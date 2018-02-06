From: sebastian.reichel@collabora.co.uk (Sebastian Reichel)
Date: Tue,  6 Feb 2018 15:26:29 +0100
Subject: [PATCHv2 3/3] ARM: dts: imx53: PPD: Enable secure-reg-access
In-Reply-To: <20180206142629.534-1-sebastian.reichel@collabora.co.uk>
References: <20180206142629.534-1-sebastian.reichel@collabora.co.uk>
Message-ID: <20180206142629.534-4-sebastian.reichel@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Peter Senna Tschudin <peter.senna@collabora.com>

Add secure-reg-access on PPD device tree to enable PMU and
hardware counters for perf.

Signed-off-by: Peter Senna Tschudin <peter.senna@collabora.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 arch/arm/boot/dts/imx53-ppd.dts | 4 ++++
 arch/arm/boot/dts/imx53.dtsi    | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx53-ppd.dts b/arch/arm/boot/dts/imx53-ppd.dts
index cce959438a79..4ecbe6e4eecb 100644
--- a/arch/arm/boot/dts/imx53-ppd.dts
+++ b/arch/arm/boot/dts/imx53-ppd.dts
@@ -556,6 +556,10 @@
 	};
 };
 
+&pmu {
+	secure-reg-access;
+};
+
 &pwm1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm1>;
diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index 1040251f2951..7df4853dc771 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -116,7 +116,7 @@
 		};
 	};
 
-	pmu {
+	pmu: pmu {
 		compatible = "arm,cortex-a8-pmu";
 		interrupt-parent = <&tzic>;
 		interrupts = <77>;
-- 
2.15.1

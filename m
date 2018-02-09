From: sebastian.reichel@collabora.co.uk (Sebastian Reichel)
Date: Fri,  9 Feb 2018 18:03:58 +0100
Subject: [PATCHv3 2/2] ARM: dts: imx53: PPD: Enable secure-reg-access
In-Reply-To: <20180209170358.7227-1-sebastian.reichel@collabora.co.uk>
References: <20180209170358.7227-1-sebastian.reichel@collabora.co.uk>
Message-ID: <20180209170358.7227-3-sebastian.reichel@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add secure-reg-access on PPD device tree to enable PMU and
hardware counters for perf.

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

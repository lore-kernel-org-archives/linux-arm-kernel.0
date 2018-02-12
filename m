From: sebastian.reichel@collabora.co.uk (Sebastian Reichel)
Date: Mon, 12 Feb 2018 13:39:45 +0100
Subject: [PATCHv4 2/2] ARM: dts: imx53: PPD: Enable secure-reg-access
In-Reply-To: <20180212123945.15732-1-sebastian.reichel@collabora.co.uk>
References: <20180212123945.15732-1-sebastian.reichel@collabora.co.uk>
Message-ID: <20180212123945.15732-3-sebastian.reichel@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add secure-reg-access on PPD device tree to enable PMU and
hardware counters for perf.

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 arch/arm/boot/dts/imx53-ppd.dts | 4 ++++
 arch/arm/boot/dts/imx53.dtsi    | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx53-ppd.dts b/arch/arm/boot/dts/imx53-ppd.dts
index dd1b524e5074..3c87e0d73f63 100644
--- a/arch/arm/boot/dts/imx53-ppd.dts
+++ b/arch/arm/boot/dts/imx53-ppd.dts
@@ -562,6 +562,10 @@
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

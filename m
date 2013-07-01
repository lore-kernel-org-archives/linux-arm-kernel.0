From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 01 Jul 2013 17:22:33 +0200
Subject: [PATCH v3 11/13] ARM: dts: Add Exynos4210 SoC camera port pinctrl
 nodes
In-Reply-To: <1372692155-17653-1-git-send-email-s.nawrocki@samsung.com>
References: <1372692155-17653-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <1372692155-17653-12-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrzej Hajda <a.hajda@samsung.com>

Add pinctrl nodes for the camera parallel port CAM_A data bus
and the CAM_A_CLKOUT clock output pin.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/boot/dts/exynos4210-pinctrl.dtsi |   23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4210-pinctrl.dtsi b/arch/arm/boot/dts/exynos4210-pinctrl.dtsi
index 553bcea..a7c2128 100644
--- a/arch/arm/boot/dts/exynos4210-pinctrl.dtsi
+++ b/arch/arm/boot/dts/exynos4210-pinctrl.dtsi
@@ -797,6 +797,29 @@
 			samsung,pin-pud = <0>;
 			samsung,pin-drv = <0>;
 		};
+
+		cam_port_a_io: cam-port-a-io {
+			samsung,pins = "gpj0-0", "gpj0-1", "gpj0-2", "gpj0-3",
+					"gpj0-4", "gpj0-5", "gpj0-6", "gpj0-7",
+					"gpj1-0", "gpj1-1", "gpj1-2", "gpj1-4";
+			samsung,pin-function = <2>;
+			samsung,pin-pud = <0>;
+			samsung,pin-drv = <0>;
+		};
+
+		cam_port_a_clk_active: cam-port-a-clk-active {
+			samsung,pins = "gpj1-3";
+			samsung,pin-function = <2>;
+			samsung,pin-pud = <0>;
+			samsung,pin-drv = <3>;
+		};
+
+		cam_port_a_clk_idle: cam-port-a-clk-idle {
+			samsung,pins = "gpj1-3";
+			samsung,pin-function = <0>;
+			samsung,pin-pud = <1>;
+			samsung,pin-drv = <0>;
+		};
 	};
 
 	pinctrl at 03860000 {
-- 
1.7.9.5

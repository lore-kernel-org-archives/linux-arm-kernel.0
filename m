From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Tue, 25 Jun 2013 10:48:34 +0200
Subject: [PATCH v2 5/6] ARM: rockchip: add power-management-unit dt node
In-Reply-To: <201306251046.04873.heiko@sntech.de>
References: <201306251046.04873.heiko@sntech.de>
Message-ID: <201306251048.34668.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pmu is needed to bring up the cores during smp operations.
Therefore add a node and documentation for it.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 Documentation/devicetree/bindings/arm/rockchip/pmu.txt |   16 ++++++++++++++++
 arch/arm/boot/dts/rk3066a.dtsi                         |    5 +++++
 2 files changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/rockchip/pmu.txt

diff --git a/Documentation/devicetree/bindings/arm/rockchip/pmu.txt b/Documentation/devicetree/bindings/arm/rockchip/pmu.txt
new file mode 100644
index 0000000..3ee9b42
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/rockchip/pmu.txt
@@ -0,0 +1,16 @@
+Rockchip power-management-unit:
+-------------------------------
+
+The pmu is used to turn off and on different power domains of the SoCs
+This includes the power to the CPU cores.
+
+Required node properties:
+- compatible value : = "rockchip,rk3066-pmu";
+- reg : physical base address and the size of the registers window
+
+Example:
+
+	pmu at 20004000 {
+		compatible = "rockchip,rk3066-pmu";
+		reg = <0x20004000 0x100>;
+	};
diff --git a/arch/arm/boot/dts/rk3066a.dtsi b/arch/arm/boot/dts/rk3066a.dtsi
index 24d1941..43ac7c8 100644
--- a/arch/arm/boot/dts/rk3066a.dtsi
+++ b/arch/arm/boot/dts/rk3066a.dtsi
@@ -59,6 +59,11 @@
 			mmio-sram-reserved = <0x0 0x50>;
 		};
 
+		pmu at 20004000 {
+			compatible = "rockchip,rk3066-pmu";
+			reg = <0x20004000 0x100>;
+		};
+
 		gic: interrupt-controller at 1013d000 {
 			compatible = "arm,cortex-a9-gic";
 			interrupt-controller;
-- 
1.7.10.4

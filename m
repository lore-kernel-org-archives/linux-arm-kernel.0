From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 15 Jan 2014 22:43:11 +0100
Subject: [PATCH v6 5/6] ARM: rockchip: add power-management-unit
In-Reply-To: <27256277.YJ687suYy5@phil>
References: <27256277.YJ687suYy5@phil>
Message-ID: <2033803.ve2pEnCxjZ@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pmu is needed to bring up the cores during smp operations and later
also other system parts. Therefore add a node and documentation for it.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: Ulrich Prinz <ulrich.prinz@googlemail.com>
---
 Documentation/devicetree/bindings/arm/rockchip/pmu.txt |   16 ++++++++++++++++
 arch/arm/boot/dts/rk3xxx.dtsi                          |    5 +++++
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
diff --git a/arch/arm/boot/dts/rk3xxx.dtsi b/arch/arm/boot/dts/rk3xxx.dtsi
index 0a3d5b1..26e5a96 100644
--- a/arch/arm/boot/dts/rk3xxx.dtsi
+++ b/arch/arm/boot/dts/rk3xxx.dtsi
@@ -31,6 +31,11 @@
 			reg = <0x1013c000 0x100>;
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

From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Fri, 26 Jul 2013 10:18:03 -0300
Subject: [PATCH v9 26/30] ARM: kirkwood: Introduce MBus DT node
In-Reply-To: <1374844687-19981-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1374844687-19981-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1374844687-19981-27-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a minimal MBus node, just to allow the MBus driver to probe.
Follow-up patches will migrate the rest of the nodes appropriately.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Tested-by: Andrew Lunn <andrew@lunn.ch>
Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
 arch/arm/boot/dts/kirkwood.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
index 9809fc1..83d53b3 100644
--- a/arch/arm/boot/dts/kirkwood.dtsi
+++ b/arch/arm/boot/dts/kirkwood.dtsi
@@ -28,6 +28,11 @@
 		      <0xf1020214 0x04>;
 	};
 
+	mbus {
+		compatible = "marvell,kirkwood-mbus", "simple-bus";
+		controller = <&mbusc>;
+	};
+
 	ocp at f1000000 {
 		compatible = "simple-bus";
 		ranges = <0x00000000 0xf1000000 0x0100000
@@ -37,6 +42,11 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 
+		mbusc: mbus-controller at 20000 {
+			compatible = "marvell,mbus-controller";
+			reg = <0x20000 0x80>, <0x1500 0x20>;
+		};
+
 		core_clk: core-clocks at 10030 {
 			compatible = "marvell,kirkwood-core-clock";
 			reg = <0x10030 0x4>;
-- 
1.8.1.5

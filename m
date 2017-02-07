From: chris.brandt@renesas.com (Chris Brandt)
Date: Tue,  7 Feb 2017 12:09:29 -0500
Subject: [PATCH v2 3/3] ARM: dts: r7s72100: add l2 cache
In-Reply-To: <20170207170929.29525-1-chris.brandt@renesas.com>
References: <20170207170929.29525-1-chris.brandt@renesas.com>
Message-ID: <20170207170929.29525-4-chris.brandt@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Note that arm,pl301-no-sideband is required because the sideband signals
between the CPU and L2C were not connected in this SoC.

Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
* added "arm,pl310-no-sideband"
---
 arch/arm/boot/dts/r7s72100.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/r7s72100.dtsi b/arch/arm/boot/dts/r7s72100.dtsi
index 74e684f..00b9972 100644
--- a/arch/arm/boot/dts/r7s72100.dtsi
+++ b/arch/arm/boot/dts/r7s72100.dtsi
@@ -177,6 +177,7 @@
 			compatible = "arm,cortex-a9";
 			reg = <0>;
 			clock-frequency = <400000000>;
+			next-level-cache = <&L2>;
 		};
 	};
 
@@ -368,6 +369,15 @@
 			<0xe8202000 0x1000>;
 	};
 
+	L2: cache-controller at 3ffff000 {
+		compatible = "arm,pl310-cache";
+		reg = <0x3ffff000 0x1000>;
+		interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
+		arm,pl310-no-sideband;
+		cache-unified;
+		cache-level = <2>;
+	};
+
 	i2c0: i2c at fcfee000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
2.10.1

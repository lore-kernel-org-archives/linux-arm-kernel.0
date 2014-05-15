From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 15 May 2014 20:32:00 +0900
Subject: [PATCH v6 05/17] ARM: shmobile: r8a7779: Reference clocks
In-Reply-To: <1400153532-23675-1-git-send-email-horms+renesas@verge.net.au>
References: <1400153532-23675-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1400153532-23675-6-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reference clocks using a "clocks" property in all nodes corresponding to
devices that require a clock.

Based on work by Laurent Pinchart for the r8a7790 and r8a7791 SoC.

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---
v4 - v5
* No change

v3
* Also update the following nodes which are now present
  - hspi{0,1,2}
  - sata: Suggested by Laurent Pinchart
---
 arch/arm/boot/dts/r8a7779.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index 5a62970..bdaaadc 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -158,6 +158,7 @@
 		compatible = "renesas,i2c-r8a7779";
 		reg = <0xffc70000 0x1000>;
 		interrupts = <0 79 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp0_clks R8A7779_CLK_I2C0>;
 		status = "disabled";
 	};
 
@@ -167,6 +168,7 @@
 		compatible = "renesas,i2c-r8a7779";
 		reg = <0xffc71000 0x1000>;
 		interrupts = <0 82 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp0_clks R8A7779_CLK_I2C1>;
 		status = "disabled";
 	};
 
@@ -176,6 +178,7 @@
 		compatible = "renesas,i2c-r8a7779";
 		reg = <0xffc72000 0x1000>;
 		interrupts = <0 80 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp0_clks R8A7779_CLK_I2C2>;
 		status = "disabled";
 	};
 
@@ -185,6 +188,7 @@
 		compatible = "renesas,i2c-r8a7779";
 		reg = <0xffc73000 0x1000>;
 		interrupts = <0 81 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp0_clks R8A7779_CLK_I2C3>;
 		status = "disabled";
 	};
 
@@ -202,12 +206,14 @@
 		compatible = "renesas,rcar-sata";
 		reg = <0xfc600000 0x2000>;
 		interrupts = <0 100 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp1_clks R8A7779_CLK_SATA>;
 	};
 
 	sdhi0: sd at ffe4c000 {
 		compatible = "renesas,sdhi-r8a7779";
 		reg = <0xffe4c000 0x100>;
 		interrupts = <0 104 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7779_CLK_SDHI0>;
 		cap-sd-highspeed;
 		cap-sdio-irq;
 		status = "disabled";
@@ -217,6 +223,7 @@
 		compatible = "renesas,sdhi-r8a7779";
 		reg = <0xffe4d000 0x100>;
 		interrupts = <0 105 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7779_CLK_SDHI1>;
 		cap-sd-highspeed;
 		cap-sdio-irq;
 		status = "disabled";
@@ -226,6 +233,7 @@
 		compatible = "renesas,sdhi-r8a7779";
 		reg = <0xffe4e000 0x100>;
 		interrupts = <0 107 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7779_CLK_SDHI2>;
 		cap-sd-highspeed;
 		cap-sdio-irq;
 		status = "disabled";
@@ -235,6 +243,7 @@
 		compatible = "renesas,sdhi-r8a7779";
 		reg = <0xffe4f000 0x100>;
 		interrupts = <0 106 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7779_CLK_SDHI3>;
 		cap-sd-highspeed;
 		cap-sdio-irq;
 		status = "disabled";
@@ -246,6 +255,7 @@
 		interrupts = <0 73 IRQ_TYPE_LEVEL_HIGH>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		clocks = <&mstp0_clks R8A7779_CLK_HSPI>;
 		status = "disabled";
 	};
 
@@ -255,6 +265,7 @@
 		interrupts = <0 74 IRQ_TYPE_LEVEL_HIGH>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		clocks = <&mstp0_clks R8A7779_CLK_HSPI>;
 		status = "disabled";
 	};
 
@@ -264,6 +275,7 @@
 		interrupts = <0 75 IRQ_TYPE_LEVEL_HIGH>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		clocks = <&mstp0_clks R8A7779_CLK_HSPI>;
 		status = "disabled";
 	};
 
-- 
1.8.5.2

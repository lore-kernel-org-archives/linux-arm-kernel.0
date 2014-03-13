From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 13 Mar 2014 17:59:50 +0900
Subject: [PATCH v4 07/19] ARM: shmobile: r8a7779: Reference clocks
In-Reply-To: <1394701202-25823-1-git-send-email-horms+renesas@verge.net.au>
References: <1394701202-25823-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1394701202-25823-8-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reference clocks using a "clocks" property in all nodes corresponding to
devices that require a clock.

Based on work by Laurent Pinchart for the r8a7790 and r8a7791 SoC.

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---
v3
* Also update the following nodes which are now present
  - hspi{0,1,2}
  - sata: Suggested by Laurent Pinchart
---
 arch/arm/boot/dts/r8a7779.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index c0802aa..dbdc92d 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -166,6 +166,7 @@
 		reg = <0xffc70000 0x1000>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 79 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp0_clks R8A7779_CLK_I2C0>;
 		status = "disabled";
 	};
 
@@ -176,6 +177,7 @@
 		reg = <0xffc71000 0x1000>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 82 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp0_clks R8A7779_CLK_I2C1>;
 		status = "disabled";
 	};
 
@@ -186,6 +188,7 @@
 		reg = <0xffc72000 0x1000>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 80 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp0_clks R8A7779_CLK_I2C2>;
 		status = "disabled";
 	};
 
@@ -196,6 +199,7 @@
 		reg = <0xffc73000 0x1000>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 81 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp0_clks R8A7779_CLK_I2C3>;
 		status = "disabled";
 	};
 
@@ -214,6 +218,7 @@
 		reg = <0xfc600000 0x2000>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 100 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp1_clks R8A7779_CLK_SATA>;
 	};
 
 	sdhi0: sd at ffe4c000 {
@@ -221,6 +226,7 @@
 		reg = <0xffe4c000 0x100>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 104 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7779_CLK_SDHI0>;
 		cap-sd-highspeed;
 		cap-sdio-irq;
 		status = "disabled";
@@ -231,6 +237,7 @@
 		reg = <0xffe4d000 0x100>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 105 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7779_CLK_SDHI1>;
 		cap-sd-highspeed;
 		cap-sdio-irq;
 		status = "disabled";
@@ -241,6 +248,7 @@
 		reg = <0xffe4e000 0x100>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 107 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7779_CLK_SDHI2>;
 		cap-sd-highspeed;
 		cap-sdio-irq;
 		status = "disabled";
@@ -251,6 +259,7 @@
 		reg = <0xffe4f000 0x100>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 106 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7779_CLK_SDHI3>;
 		cap-sd-highspeed;
 		cap-sdio-irq;
 		status = "disabled";
@@ -261,6 +270,7 @@
 		reg = <0xfffc7000 0x18>;
 		interrupt-controller = <&gic>;
 		interrupts = <0 73 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp0_clks R8A7779_CLK_HSPI>;
 		status = "disabled";
 	};
 
@@ -269,6 +279,7 @@
 		reg = <0xfffc8000 0x18>;
 		interrupt-controller = <&gic>;
 		interrupts = <0 74 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp0_clks R8A7779_CLK_HSPI>;
 		status = "disabled";
 	};
 
@@ -277,6 +288,7 @@
 		reg = <0xfffc6000 0x18>;
 		interrupt-controller = <&gic>;
 		interrupts = <0 75 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp0_clks R8A7779_CLK_HSPI>;
 		status = "disabled";
 	};
 
-- 
1.8.5.2

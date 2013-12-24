From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 24 Dec 2013 23:19:38 +0900
Subject: [PATCH 08/21] ARM: shmobile: r8a7790: Reference clocks
In-Reply-To: <cover.1387893834.git.horms+renesas@verge.net.au>
References: <cover.1387893834.git.horms+renesas@verge.net.au>
Message-ID: <72197ca7a1cb1cea5615c879f638d5d457c0b2e2.1387893834.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Reference clocks using a "clocks" property in all nodes corresponding to
devices that require a clock.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 8dccbe7..71ec31c 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -197,6 +197,7 @@
 		reg = <0 0xe6508000 0 0x40>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 287 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7790_CLK_I2C0>;
 		status = "disabled";
 	};
 
@@ -207,6 +208,7 @@
 		reg = <0 0xe6518000 0 0x40>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 288 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7790_CLK_I2C1>;
 		status = "disabled";
 	};
 
@@ -217,6 +219,7 @@
 		reg = <0 0xe6530000 0 0x40>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 286 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7790_CLK_I2C2>;
 		status = "disabled";
 	};
 
@@ -227,6 +230,7 @@
 		reg = <0 0xe6540000 0 0x40>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 290 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7790_CLK_I2C3>;
 		status = "disabled";
 	};
 
@@ -235,6 +239,7 @@
 		reg = <0 0xee200000 0 0x80>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 169 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7790_CLK_MMCIF0>;
 		reg-io-width = <4>;
 		status = "disabled";
 	};
@@ -244,6 +249,7 @@
 		reg = <0 0xee220000 0 0x80>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 170 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7790_CLK_MMCIF1>;
 		reg-io-width = <4>;
 		status = "disabled";
 	};
@@ -258,6 +264,7 @@
 		reg = <0 0xee100000 0 0x100>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 165 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7790_CLK_SDHI0>;
 		cap-sd-highspeed;
 		status = "disabled";
 	};
@@ -267,6 +274,7 @@
 		reg = <0 0xee120000 0 0x100>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 166 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7790_CLK_SDHI1>;
 		cap-sd-highspeed;
 		status = "disabled";
 	};
@@ -276,6 +284,7 @@
 		reg = <0 0xee140000 0 0x100>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 167 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7790_CLK_SDHI2>;
 		cap-sd-highspeed;
 		status = "disabled";
 	};
@@ -285,6 +294,7 @@
 		reg = <0 0xee160000 0 0x100>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 168 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7790_CLK_SDHI3>;
 		cap-sd-highspeed;
 		status = "disabled";
 	};
-- 
1.8.4

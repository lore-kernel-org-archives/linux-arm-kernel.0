From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Sun, 10 Nov 2013 04:09:37 +0100
Subject: [PATCH v2 7/7] ARM: shmobile: r8a7790: Reference clocks
In-Reply-To: <1384052977-30616-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1384052977-30616-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1384052977-30616-8-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reference clocks using a "clocks" property in all nodes corresponding to
devices that require a clock.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a7790.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 5d8c8c7..098b2d6 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -185,6 +185,7 @@
 		reg = <0 0xe6508000 0 0x40>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 287 0x4>;
+		clocks = <&mstp3_clks R8A7790_CLK_I2C0>;
 		status = "disabled";
 	};
 
@@ -195,6 +196,7 @@
 		reg = <0 0xe6518000 0 0x40>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 288 0x4>;
+		clocks = <&mstp3_clks R8A7790_CLK_I2C1>;
 		status = "disabled";
 	};
 
@@ -205,6 +207,7 @@
 		reg = <0 0xe6530000 0 0x40>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 286 0x4>;
+		clocks = <&mstp3_clks R8A7790_CLK_I2C2>;
 		status = "disabled";
 	};
 
@@ -215,6 +218,7 @@
 		reg = <0 0xe6540000 0 0x40>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 290 0x4>;
+		clocks = <&mstp3_clks R8A7790_CLK_I2C3>;
 		status = "disabled";
 	};
 
@@ -223,6 +227,7 @@
 		reg = <0 0xee200000 0 0x80>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 169 0x4>;
+		clocks = <&mstp3_clks R8A7790_CLK_MMCIF0>;
 		reg-io-width = <4>;
 		status = "disabled";
 	};
@@ -232,6 +237,7 @@
 		reg = <0 0xee220000 0 0x80>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 170 0x4>;
+		clocks = <&mstp3_clks R8A7790_CLK_MMCIF1>;
 		reg-io-width = <4>;
 		status = "disabled";
 	};
@@ -246,6 +252,7 @@
 		reg = <0 0xee100000 0 0x100>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 165 4>;
+		clocks = <&mstp3_clks R8A7790_CLK_SDHI0>;
 		cap-sd-highspeed;
 		status = "disabled";
 	};
@@ -255,6 +262,7 @@
 		reg = <0 0xee120000 0 0x100>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 166 4>;
+		clocks = <&mstp3_clks R8A7790_CLK_SDHI1>;
 		cap-sd-highspeed;
 		status = "disabled";
 	};
@@ -264,6 +272,7 @@
 		reg = <0 0xee140000 0 0x100>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 167 4>;
+		clocks = <&mstp3_clks R8A7790_CLK_SDHI2>;
 		cap-sd-highspeed;
 		status = "disabled";
 	};
@@ -273,6 +282,7 @@
 		reg = <0 0xee160000 0 0x100>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 168 4>;
+		clocks = <&mstp3_clks R8A7790_CLK_SDHI3>;
 		cap-sd-highspeed;
 		status = "disabled";
 	};
-- 
1.8.1.5

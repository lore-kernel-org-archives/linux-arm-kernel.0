From: avinashphilip@ti.com (Philip Avinash)
Date: Fri, 18 Jan 2013 12:11:34 +0530
Subject: [PATCH 2/3] ARM: dts: AM33XX: Add GPMC node
In-Reply-To: <1358491295-4022-1-git-send-email-avinashphilip@ti.com>
References: <1358491295-4022-1-git-send-email-avinashphilip@ti.com>
Message-ID: <1358491295-4022-3-git-send-email-avinashphilip@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Philip, Avinash" <avinashphilip@ti.com>

Add GPMC data node to AM33XX device tree file.

Signed-off-by: Philip Avinash <avinashphilip@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index eaef5e7..f4209d8 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -393,5 +393,17 @@
 			ti,hwmods = "elm";
 			status = "disabled";
 		};
+
+		gpmc: gpmc at 50000000 {
+			compatible = "ti,am3352-gpmc";
+			ti,hwmods = "gpmc";
+			reg = <0x50000000 0x2000>;
+			interrupts = <100>;
+			num-cs = <8>;
+			num-waitpins = <2>;
+			#address-cells = <2>;
+			#size-cells = <1>;
+			status = "disabled";
+		};
 	};
 };
-- 
1.7.9.5

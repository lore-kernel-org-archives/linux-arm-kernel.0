From: d-gerlach@ti.com (Dave Gerlach)
Date: Mon, 9 May 2016 16:49:22 -0500
Subject: [PATCH 2/6] ARM: dts: omap3: Add ocmcram node
In-Reply-To: <1462830566-28708-1-git-send-email-d-gerlach@ti.com>
References: <1462830566-28708-1-git-send-email-d-gerlach@ti.com>
Message-ID: <1462830566-28708-3-git-send-email-d-gerlach@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add an ocmcram node to omap3 dtsi using the mmio-sram driver to
represent the 64kb of SRAM available on omap3 and it's derivatives.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/boot/dts/omap3.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index b41d07e8e765..a267616c3c68 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -59,6 +59,7 @@
 		mpu {
 			compatible = "ti,omap3-mpu";
 			ti,hwmods = "mpu";
+			sram = <&ocmcram>;
 		};
 
 		iva: iva {
@@ -153,6 +154,16 @@
 			};
 		};
 
+		ocmcram: ocmcram at 40200000 {
+			compatible = "mmio-sram";
+			reg = <0x40200000 0x10000>; /* 64k */
+			memory-exec-nocache;
+			ranges = <0x0 0x40200000 0x10000>;
+
+			#address-cells = <1>;
+			#size-cells = <1>;
+		};
+
 		aes: aes at 480c5000 {
 			compatible = "ti,omap3-aes";
 			ti,hwmods = "aes";
-- 
2.7.3

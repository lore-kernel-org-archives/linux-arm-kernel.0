From: sathyap@ti.com (Sathya Prakash M R)
Date: Mon, 22 Jul 2013 11:33:17 +0530
Subject: [PATCH 2/2] ARM: DTS: AM43x: Add DSS node
In-Reply-To: <1374472997-9653-1-git-send-email-sathyap@ti.com>
References: <1374472997-9653-1-git-send-email-sathyap@ti.com>
Message-ID: <1374472997-9653-3-git-send-email-sathyap@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device node for DSS module for AM43x

Signed-off-by: Sathya Prakash M R <sathyap@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi |   27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index ddc1df7..f10fc0a 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -64,5 +64,32 @@
 			compatible = "ti,am4372-counter32k","ti,omap-counter32k";
 			reg = <0x44e86000 0x40>;
 		};
+
+		dss: dss at 4832A000 {
+			compatible = "ti,omap3-dss", "simple-bus";
+			reg = <0x4832A000 0x200>;
+			ti,hwmods = "dss_core";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			dispc at 4832A400 {
+				compatible = "ti,omap3-dispc";
+				reg = <0x4832A400 0x400>;
+				interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
+				ti,hwmods = "dss_dispc";
+			};
+
+			dpi: dpi {
+				compatible = "ti,omap3-dpi";
+			};
+
+			rfbi: rfbi at 4832A800 {
+				compatible = "ti,omap3-rfbi";
+				reg = <0x4832A800 0x100>;
+				ti,hwmods = "dss_rfbi";
+			};
+
+		};
 	};
 };
-- 
1.7.9.5

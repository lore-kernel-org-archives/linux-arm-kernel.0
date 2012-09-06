From: avinashphilip@ti.com (Philip, Avinash)
Date: Thu, 6 Sep 2012 12:30:15 +0530
Subject: [PATCH RESEND] arm/dts: AM33XX: Add SPI device tree data
Message-ID: <1346914815-860-1-git-send-email-avinashphilip@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add McSPI data node to AM33XX device tree file. The McSPI module (and so
as the driver) is reused from OMAP4.

Signed-off-by: Philip, Avinash <avinashphilip@ti.com>
---
Resenting patch because ARM & OMAP mailing list was not copied.

:100644 100644 bb31bff... 6b469bd... M	arch/arm/boot/dts/am33xx.dtsi
 arch/arm/boot/dts/am33xx.dtsi |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index bb31bff..6b469bd 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -210,5 +210,30 @@
 			interrupt-parent = <&intc>;
 			interrupts = <91>;
 		};
+
+		spi0: spi at 48030000 {
+			compatible = "ti,omap4-mcspi";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x4830000 0x400>;
+			interrupt-parent = <&intc>;
+			interrupt = <65>;
+			ti,spi-num-cs = <2>;
+			ti,hwmods = "spi0";
+			status = "disabled";
+
+		};
+
+		spi1: spi at 481a0000 {
+			compatible = "ti,omap4-mcspi";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x481a0000 0x400>;
+			interrupt-parent = <&intc>;
+			interrupt = <125>;
+			ti,spi-num-cs = <2>;
+			ti,hwmods = "spi1";
+			status = "disabled";
+		};
 	};
 };
-- 
1.7.1

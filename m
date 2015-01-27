From: bhuvanchandra.dv@toradex.com (Bhuvanchandra DV)
Date: Tue, 27 Jan 2015 16:27:18 +0530
Subject: [PATCH 1/7] ARM: vf610: add second DSPI instance
In-Reply-To: <1422356244-15629-1-git-send-email-bhuvanchandra.dv@toradex.com>
References: <1422356244-15629-1-git-send-email-bhuvanchandra.dv@toradex.com>
Message-ID: <1422356244-15629-2-git-send-email-bhuvanchandra.dv@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Acked-by: Stefan Agner <stefan@agner.ch>
Signed-off-by: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
---
 arch/arm/boot/dts/vf500.dtsi |  4 ++++
 arch/arm/boot/dts/vfxxx.dtsi | 11 +++++++++++
 2 files changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/vf500.dtsi b/arch/arm/boot/dts/vf500.dtsi
index 1dbf8d2..f5f807c 100644
--- a/arch/arm/boot/dts/vf500.dtsi
+++ b/arch/arm/boot/dts/vf500.dtsi
@@ -66,6 +66,10 @@
 	interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
 };
 
+&dspi1 {
+	interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
+};
+
 &edma0 {
 	interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
 			<GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm/boot/dts/vfxxx.dtsi b/arch/arm/boot/dts/vfxxx.dtsi
index a29c7ce..789744b 100644
--- a/arch/arm/boot/dts/vfxxx.dtsi
+++ b/arch/arm/boot/dts/vfxxx.dtsi
@@ -139,6 +139,17 @@
 				status = "disabled";
 			};
 
+			dspi1: dspi1 at 4002d000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,vf610-dspi";
+				reg = <0x4002d000 0x1000>;
+				clocks = <&clks VF610_CLK_DSPI1>;
+				clock-names = "dspi";
+				spi-num-chipselects = <5>;
+				status = "disabled";
+			};
+
 			sai2: sai at 40031000 {
 				compatible = "fsl,vf610-sai";
 				reg = <0x40031000 0x1000>;
-- 
2.2.2

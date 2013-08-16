From: b44548@freescale.com (Chao Fu)
Date: Fri, 16 Aug 2013 11:08:52 +0800
Subject: [PATCH v3 1/4] ARM:dts: vf610: Add DSPI nodes
In-Reply-To: <1376622535-8474-1-git-send-email-b44548@freescale.com>
References: <1376622535-8474-1-git-send-email-b44548@freescale.com>
Message-ID: <1376622535-8474-2-git-send-email-b44548@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chao Fu <B44548@freescale.com>

Add Freescale DSPI node into vf610 dts.

Signed-off-by: Chao Fu <b44548@freescale.com>
---
 arch/arm/boot/dts/vf610.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/vf610.dtsi b/arch/arm/boot/dts/vf610.dtsi
index 67d929c..af687a4 100644
--- a/arch/arm/boot/dts/vf610.dtsi
+++ b/arch/arm/boot/dts/vf610.dtsi
@@ -87,6 +87,18 @@
 				arm,tag-latency = <2 2 2>;
 			};
 
+			dspi0: dspi0 at 4002c000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,vf610-dspi";
+				reg = <0x4002c000 0x1000>;
+				interrupts = <0 67 0x04>;
+				clocks = <&clks VF610_CLK_DSPI0>;
+				clock-names = "dspi";
+				spi-num-chipselects = <5>;
+				status = "disabled";
+			};
+
 			uart0: serial at 40027000 {
 				compatible = "fsl,vf610-lpuart";
 				reg = <0x40027000 0x1000>;
-- 
1.8.0

From: b44548@freescale.com (Chao Fu)
Date: Mon, 8 Jul 2013 16:37:01 +0800
Subject: [PATCH 2/3] ARM:dts: vf610: Add DSPI nodes
In-Reply-To: <1373272622-29064-1-git-send-email-b44548@freescale.com>
References: <1373272622-29064-1-git-send-email-b44548@freescale.com>
Message-ID: <1373272622-29064-2-git-send-email-b44548@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chao Fu <B44548@freescale.com>

Add Freescale DSPI node into vf610 dts.

Signed-off-by: Chao Fu <b44548@freescale.com>
---
 arch/arm/boot/dts/vf610.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/vf610.dtsi b/arch/arm/boot/dts/vf610.dtsi
index e1eb7da..fc80f4a 100644
--- a/arch/arm/boot/dts/vf610.dtsi
+++ b/arch/arm/boot/dts/vf610.dtsi
@@ -87,6 +87,17 @@
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
+				status = "disabled";
+			};
+
 			uart0: serial at 40027000 {
 				compatible = "fsl,vf610-lpuart";
 				reg = <0x40027000 0x1000>;
-- 
1.8.0

From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Wed,  9 Apr 2014 15:51:12 +0200
Subject: [PATCH 09/15] clk: sunxi: add A31 APB0 reset line defintions
In-Reply-To: <1397051478-4113-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1397051478-4113-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1397051478-4113-10-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add APB0 reset line support for the A31 SoC.
This reset lines are controlled by the PRCM (Power/Reset/Clock Management) block
and thus will act on a different iomem range.

Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index 61e8b34..ed9c2c1 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -237,6 +237,12 @@
 			reg = <0x01c202c0 0xc>;
 		};
 
+		apb0_rst: reset at 01f014b0 {
+			#reset-cells = <1>;
+			compatible = "allwinner,sun6i-a31-clock-reset";
+			reg = <0x01f014b0 0x4>;
+		};
+
 		apb1_rst: reset at 01c202d0 {
 			#reset-cells = <1>;
 			compatible = "allwinner,sun6i-a31-clock-reset";
-- 
1.8.3.2

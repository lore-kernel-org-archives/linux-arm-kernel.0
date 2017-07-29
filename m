From: abhishek.shah@broadcom.com (Abhishek Shah)
Date: Sat, 29 Jul 2017 10:12:25 +0530
Subject: [PATCH 3/7] arm64: dts: Add sp804 DT nodes for Stingray SoC
In-Reply-To: <1501303349-30007-1-git-send-email-abhishek.shah@broadcom.com>
References: <1501303349-30007-1-git-send-email-abhishek.shah@broadcom.com>
Message-ID: <1501303349-30007-4-git-send-email-abhishek.shah@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Anup Patel <anup.patel@broadcom.com>

We have 8 instances of sp804 in Stingray SoC. Let's enable
it in Stingray DT.

Signed-off-by: Anup Patel <anup.patel@broadcom.com>
Reviewed-by: Ray Jui <rjui@broadcom.com>
Reviewed-by: Scott Branden <sbranden@broadcom.com>
---
 .../arm64/boot/dts/broadcom/stingray/stingray.dtsi | 87 ++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
index 697401d..19ad887 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
+++ b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
@@ -314,6 +314,93 @@
 			status = "disabled";
 		};
 
+		timer0: timer at 00030000 {
+			compatible = "arm,sp804", "arm,primecell";
+			reg = <0x00030000 0x1000>;
+			interrupts = <GIC_SPI 179 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&hsls_25m_div2_clk>,
+				 <&hsls_25m_div2_clk>,
+				 <&hsls_div4_clk>;
+			clock-names = "timer1", "timer2", "apb_pclk";
+			status = "disabled";
+		};
+
+		timer1: timer at 00040000 {
+			compatible = "arm,sp804", "arm,primecell";
+			reg = <0x00040000 0x1000>;
+			interrupts = <GIC_SPI 180 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&hsls_25m_div2_clk>,
+				 <&hsls_25m_div2_clk>,
+				 <&hsls_div4_clk>;
+			clock-names = "timer1", "timer2", "apb_pclk";
+		};
+
+		timer2: timer at 00050000 {
+			compatible = "arm,sp804", "arm,primecell";
+			reg = <0x00050000 0x1000>;
+			interrupts = <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&hsls_25m_div2_clk>,
+				 <&hsls_25m_div2_clk>,
+				 <&hsls_div4_clk>;
+			clock-names = "timer1", "timer2", "apb_pclk";
+			status = "disabled";
+		};
+
+		timer3: timer at 00060000 {
+			compatible = "arm,sp804", "arm,primecell";
+			reg = <0x00060000 0x1000>;
+			interrupts = <GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&hsls_25m_div2_clk>,
+				 <&hsls_25m_div2_clk>,
+				 <&hsls_div4_clk>;
+			clock-names = "timer1", "timer2", "apb_pclk";
+			status = "disabled";
+		};
+
+		timer4: timer at 00070000 {
+			compatible = "arm,sp804", "arm,primecell";
+			reg = <0x00070000 0x1000>;
+			interrupts = <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&hsls_25m_div2_clk>,
+				 <&hsls_25m_div2_clk>,
+				 <&hsls_div4_clk>;
+			clock-names = "timer1", "timer2", "apb_pclk";
+			status = "disabled";
+		};
+
+		timer5: timer at 00080000 {
+			compatible = "arm,sp804", "arm,primecell";
+			reg = <0x00080000 0x1000>;
+			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&hsls_25m_div2_clk>,
+				 <&hsls_25m_div2_clk>,
+				 <&hsls_div4_clk>;
+			clock-names = "timer1", "timer2", "apb_pclk";
+			status = "disabled";
+		};
+
+		timer6: timer at 00090000 {
+			compatible = "arm,sp804", "arm,primecell";
+			reg = <0x00090000 0x1000>;
+			interrupts = <GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&hsls_25m_div2_clk>,
+				 <&hsls_25m_div2_clk>,
+				 <&hsls_div4_clk>;
+			clock-names = "timer1", "timer2", "apb_pclk";
+			status = "disabled";
+		};
+
+		timer7: timer at 000a0000 {
+			compatible = "arm,sp804", "arm,primecell";
+			reg = <0x000a0000 0x1000>;
+			interrupts = <GIC_SPI 210 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&hsls_25m_div2_clk>,
+				 <&hsls_25m_div2_clk>,
+				 <&hsls_div4_clk>;
+			clock-names = "timer1", "timer2", "apb_pclk";
+			status = "disabled";
+		};
+
 		i2c0: i2c at 000b0000 {
 			compatible = "brcm,iproc-i2c";
 			reg = <0x000b0000 0x100>;
-- 
2.7.4

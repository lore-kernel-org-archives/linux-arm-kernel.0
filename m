From: josh.wu@atmel.com (Josh Wu)
Date: Wed, 4 Mar 2015 10:51:47 +0800
Subject: [PATCH v4 1/2] ARM: at91: sama5d4/dts: add #{address,
 size}_cells properties for macb0
Message-ID: <1425437508-30976-1-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

macb0 DT node can have phy child nodes, so add the #{address,
size}_cells for macb0 node.

Signed-off-by: Josh Wu <josh.wu@atmel.com>
---

Changes in v4:
- fix typo in commit message: cell -> cells

Changes in v3:
- new added

Changes in v2: None

 arch/arm/boot/dts/sama5d4.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
index d986b41..07953f2 100644
--- a/arch/arm/boot/dts/sama5d4.dtsi
+++ b/arch/arm/boot/dts/sama5d4.dtsi
@@ -852,6 +852,8 @@
 				interrupts = <54 IRQ_TYPE_LEVEL_HIGH 3>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_macb0_rmii>;
+				#address-cells = <1>;
+				#size-cells = <0>;
 				clocks = <&macb0_clk>, <&macb0_clk>;
 				clock-names = "hclk", "pclk";
 				status = "disabled";
-- 
1.9.1

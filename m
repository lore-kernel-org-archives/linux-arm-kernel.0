From: Anson.Huang@nxp.com (Anson Huang)
Date: Tue, 23 Jan 2018 23:12:23 +0800
Subject: [PATCH] ARM: dts: imx6sx: add pu power domain support
Message-ID: <1516720343-21933-1-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add PU power domain support, GPU is the only
module inside PU power domain, and PU power
is supplied by LDO_SOC.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6sx.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index fd78793..42ef4c6 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -188,6 +188,7 @@
 				 <&clks IMX6SX_CLK_GPU>,
 				 <&clks IMX6SX_CLK_GPU>;
 			clock-names = "bus", "core", "shader";
+			power-domains = <&pd_pu>;
 		};
 
 		dma_apbh: dma-apbh at 1804000 {
@@ -767,6 +768,13 @@
 					#address-cells = <1>;
 					#size-cells = <0>;
 
+					pd_pu: power-domain at 1 {
+						reg = <1>;
+						#power-domain-cells = <0>;
+						power-supply = <&reg_soc>;
+						clocks = <&clks IMX6SX_CLK_GPU>;
+					};
+
 					pd_pci: power-domain at 3 {
 						reg = <3>;
 						#power-domain-cells = <0>;
-- 
2.7.4

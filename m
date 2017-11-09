From: robh@kernel.org (Rob Herring)
Date: Thu,  9 Nov 2017 16:54:22 -0600
Subject: [PATCH] arm: dts: qcom: fix missing #phy-cells for apq8064
Message-ID: <20171109225422.14280-1-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix dtc warnings for missing #phy-cells for apq8064:

Warning (phys_property): Missing property '#phy-cells' in node /soc/dsi-phy at 4700200 or bad phandle (referred from /soc/mdss_dsi at 4700000:phys[0])
Warning (phys_property): Missing property '#phy-cells' in node /soc/hdmi-phy at 4a00400 or bad phandle (referred from /soc/hdmi-tx at 4a00000:phys[0])

Cc: Andy Gross <andy.gross@linaro.org>
Cc: David Brown <david.brown@linaro.org>
Cc: linux-arm-msm at vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm/boot/dts/qcom-apq8064.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index f3db185a6809..a2b030d08fc5 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -1263,6 +1263,7 @@
 		dsi0_phy: dsi-phy at 4700200 {
 			compatible = "qcom,dsi-phy-28nm-8960";
 			#clock-cells = <1>;
+			#phy-cells = <0>;
 
 			reg = <0x04700200 0x100>,
 				<0x04700300 0x200>,
@@ -1414,6 +1415,7 @@
 			      <0x4a00500 0x100>;
 			reg-names = "hdmi_phy",
 				    "hdmi_pll";
+			#phy-cells = <0>;
 
 			clocks = <&mmcc HDMI_S_AHB_CLK>;
 			clock-names = "slave_iface_clk";
-- 
2.14.1

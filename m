From: marex@denx.de (Marek Vasut)
Date: Mon, 18 Nov 2013 15:30:42 +0100
Subject: [PATCH V2 4/5] ARM: dts: imx53: Add AHCI SATA DT node
In-Reply-To: <1384785043-5027-1-git-send-email-marex@denx.de>
References: <1384785043-5027-1-git-send-email-marex@denx.de>
Message-ID: <1384785043-5027-4-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The AHCI-IMX driver now supports i.MX53 as well. Add DT node.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Richard Zhu <r65037@freescale.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Linux-IDE <linux-ide@vger.kernel.org>
---
 arch/arm/boot/dts/imx53.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

V2: Use the clock ID macros

diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index b330ef7..1ececed 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -86,6 +86,17 @@
 		interrupt-parent = <&tzic>;
 		ranges;
 
+		sata: sata at 10000000 {
+			compatible = "fsl,imx53-ahci";
+			reg = <0x10000000 0x1000>;
+			interrupts = <28>;
+			clocks = <&clks IMX5_CLK_SATA_GATE>,
+				 <&clks IMX5_CLK_SATA_PHY>,
+				 <&clks IMX5_CLK_AHB>;
+			clock-names = "sata_gate", "sata_phy", "ahb";
+			status = "disabled";
+		};
+
 		ipu: ipu at 18000000 {
 			#crtc-cells = <1>;
 			compatible = "fsl,imx53-ipu";
-- 
1.8.4.2

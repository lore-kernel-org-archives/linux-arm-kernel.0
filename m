From: marex@denx.de (Marek Vasut)
Date: Fri, 22 Nov 2013 12:05:03 +0100
Subject: [PATCH 5/6] ARM: dts: imx53: Add AHCI SATA DT node
In-Reply-To: <1385118304-27435-1-git-send-email-marex@denx.de>
References: <1385118304-27435-1-git-send-email-marex@denx.de>
Message-ID: <1385118304-27435-5-git-send-email-marex@denx.de>
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

V2: Rename 'IMX5_CLK_SATA_PHY' to 'IMX5_CLK_SATA_REF' as well as
    'sata_phy' to 'sata_ref' .

diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index b330ef7..4b2053b 100644
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
+				 <&clks IMX5_CLK_SATA_REF>,
+				 <&clks IMX5_CLK_AHB>;
+			clock-names = "sata_gate", "sata_ref", "ahb";
+			status = "disabled";
+		};
+
 		ipu: ipu at 18000000 {
 			#crtc-cells = <1>;
 			compatible = "fsl,imx53-ipu";
-- 
1.8.4.2

From: marex@denx.de (Marek Vasut)
Date: Sun, 17 Nov 2013 02:20:50 +0100
Subject: [PATCH 4/5] ARM: dts: imx53: Add AHCI SATA binding
In-Reply-To: <1384651251-5548-1-git-send-email-marex@denx.de>
References: <1384651251-5548-1-git-send-email-marex@denx.de>
Message-ID: <1384651251-5548-4-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The AHCI-IMX driver now supports i.MX53 as well. Add DT binding.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Richard Zhu <r65037@freescale.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Linux-IDE <linux-ide@vger.kernel.org>
---
 arch/arm/boot/dts/imx53.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index cffdda2..0e92af0 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -85,6 +85,15 @@
 		interrupt-parent = <&tzic>;
 		ranges;
 
+		sata: sata at 10000000 {
+			compatible = "fsl,imx53-ahci";
+			reg = <0x10000000 0x1000>;
+			interrupts = <28>;
+			clocks =  <&clks 173>, <&clks 188>, <&clks 5>;
+			clock-names = "sata_gate", "sata_phy", "ahb";
+			status = "disabled";
+		};
+
 		ipu: ipu at 18000000 {
 			#crtc-cells = <1>;
 			compatible = "fsl,imx53-ipu";
-- 
1.8.4.2

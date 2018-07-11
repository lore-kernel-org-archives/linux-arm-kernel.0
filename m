From: Anson.Huang@nxp.com (Anson Huang)
Date: Wed, 11 Jul 2018 08:58:59 +0800
Subject: [PATCH V2 2/2] ARM: dts: imx6sx: add ocram_s support
In-Reply-To: <1531270739-3075-1-git-send-email-Anson.Huang@nxp.com>
References: <1531270739-3075-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <1531270739-3075-2-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i.MX6SX has a 16KB always-on ocram bank called
ocram_s, enable it as another mmio sram.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
changes since V1:
	resort the ocram_s and ocram node by address from low to high.
 arch/arm/boot/dts/imx6sx.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 596763c..f4d982c 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -166,6 +166,12 @@
 		interrupt-parent = <&gpc>;
 		ranges;
 
+		ocram_s: sram at 8f8000 {
+			compatible = "mmio-sram";
+			reg = <0x008f8000 0x4000>;
+			clocks = <&clks IMX6SX_CLK_OCRAM_S>;
+		};
+
 		ocram: sram at 900000 {
 			compatible = "mmio-sram";
 			reg = <0x00900000 0x20000>;
-- 
2.7.4

From: Anson.Huang@nxp.com (Anson Huang)
Date: Tue, 10 Jul 2018 16:39:39 +0800
Subject: [PATCH 2/2] ARM: dts: imx6sx: add ocram_s support
In-Reply-To: <1531211979-2179-1-git-send-email-Anson.Huang@nxp.com>
References: <1531211979-2179-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <1531211979-2179-2-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i.MX6SX has a 16KB always-on ocram bank called
ocram_s, enable it as another mmio sram.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6sx.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 596763c..9923739 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -172,6 +172,12 @@
 			clocks = <&clks IMX6SX_CLK_OCRAM>;
 		};
 
+		ocram_s: sram at 8f8000 {
+			compatible = "mmio-sram";
+			reg = <0x008f8000 0x4000>;
+			clocks = <&clks IMX6SX_CLK_OCRAM_S>;
+		};
+
 		L2: l2-cache at a02000 {
 			compatible = "arm,pl310-cache";
 			reg = <0x00a02000 0x1000>;
-- 
2.7.4

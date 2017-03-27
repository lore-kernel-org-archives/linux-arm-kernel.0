From: yangbo.lu@nxp.com (Yangbo Lu)
Date: Mon, 27 Mar 2017 15:49:41 +0800
Subject: [v3, 6/7] arm64: dts: ls1046a: add clocks property and compatible for
 eSDHC node
In-Reply-To: <1490600982-5410-1-git-send-email-yangbo.lu@nxp.com>
References: <1490600982-5410-1-git-send-email-yangbo.lu@nxp.com>
Message-ID: <1490600982-5410-7-git-send-email-yangbo.lu@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The eSDHC could select peripheral clock or platform clock as clock source.
In default, we use platform clock. This patch is to add clocks property
describing peripheral clock for eSDHC node. The driver could use common clk
APIs to get peripheral clock. Also add a compatible for ls1046a eSDHC node.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
Changes for v2:
	- None
Changes for v3:
	- None
---
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index 4a164b8..141a513 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -209,10 +209,11 @@
 		};
 
 		esdhc: esdhc at 1560000 {
-			compatible = "fsl,esdhc";
+			compatible = "fsl,ls1046a-esdhc", "fsl,esdhc";
 			reg = <0x0 0x1560000 0x0 0x10000>;
 			interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
 			clock-frequency = <0>;
+			clocks = <&clockgen 2 1>;
 			voltage-ranges = <1800 1800 3300 3300>;
 			sdhci,auto-cmd12;
 			big-endian;
-- 
2.1.0.27.g96db324

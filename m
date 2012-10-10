From: b32955@freescale.com (Huang Shijie)
Date: Wed, 10 Oct 2012 18:27:09 +0800
Subject: [PATCH] ARM: dts: mxs: add the "clock-names" for gpmi-nand
In-Reply-To: <201210101237.13640.marex@denx.de>
References: <201210101237.13640.marex@denx.de>
Message-ID: <1349864829-19565-1-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current DT nodes for mx23/mx28 miss the `clocks-names` item for gpmi-nand.
So the gpmi-nand driver could not find the proper clock.

This patch fixes this issue.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 arch/arm/boot/dts/imx23.dtsi |    1 +
 arch/arm/boot/dts/imx28.dtsi |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/imx23.dtsi
index 9ca4ca7..6d31aa3 100644
--- a/arch/arm/boot/dts/imx23.dtsi
+++ b/arch/arm/boot/dts/imx23.dtsi
@@ -69,6 +69,7 @@
 				interrupts = <13>, <56>;
 				interrupt-names = "gpmi-dma", "bch";
 				clocks = <&clks 34>;
+				clock-names = "gpmi_io";
 				fsl,gpmi-dma-channel = <4>;
 				status = "disabled";
 			};
diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index e16d631..55c57ea 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -85,6 +85,7 @@
 				interrupts = <88>, <41>;
 				interrupt-names = "gpmi-dma", "bch";
 				clocks = <&clks 50>;
+				clock-names = "gpmi_io";
 				fsl,gpmi-dma-channel = <4>;
 				status = "disabled";
 			};
-- 
1.7.0.4

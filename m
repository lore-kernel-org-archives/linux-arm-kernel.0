From: b32955@freescale.com (Huang Shijie)
Date: Wed, 10 Oct 2012 10:44:46 +0800
Subject: [PATCH] ARM: dts: imx28: add the `clock-names` for gpmi-nand
Message-ID: <1349837086-21844-1-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current DT node misses the `clocks-names` item for gpmi-nand.
So the gpmi-nand driver could not find the proper clock.

This patch fixes this issue.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 arch/arm/boot/dts/imx28.dtsi |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

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

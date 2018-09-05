From: festevam@gmail.com (Fabio Estevam)
Date: Wed,  5 Sep 2018 15:18:48 -0300
Subject: [PATCH] ARM: dts: imx6ul: Enable the PMU node
Message-ID: <1536171528-23005-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

There is no need to keep the PMU disabled.

Enable it like it is done in the other i.MX dtsi files.

With this change applied we see:

[    1.338866] hw perfevents: enabled with armv7_cortex_a7 PMU driver, 5 counters available

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx6ul.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index 448d765..2a770d0 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -156,7 +156,6 @@
 		compatible = "arm,cortex-a7-pmu";
 		interrupt-parent = <&gpc>;
 		interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
-		status = "disabled";
 	};
 
 	soc {
-- 
2.7.4

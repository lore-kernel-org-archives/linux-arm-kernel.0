From: yangbo.lu@freescale.com (Yangbo Lu)
Date: Fri, 6 Nov 2015 13:43:37 +0800
Subject: [PATCH] ARM64: dts: ls2080a: fix eSDHC endianness
Message-ID: <1446788617-35736-1-git-send-email-yangbo.lu@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the "little-endian" property to fix the issue that eSDHC
is not working and dumping out "mmc0: Controller never released
inhibit bit(s)." error messages constantly.

Fixes: 5461597f6ce0 ("dts/ls2080a: Update DTSI to add support of various peripherals")
Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
index e81cd48..ed45e25 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
@@ -269,6 +269,7 @@
 			clock-frequency = <0>;	/* Updated by bootloader */
 			voltage-ranges = <1800 1800 3300 3300>;
 			sdhci,auto-cmd12;
+			little-endian;
 			bus-width = <4>;
 		};
 
-- 
2.1.0.27.g96db324

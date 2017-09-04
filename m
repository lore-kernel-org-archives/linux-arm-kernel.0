From: aford173@gmail.com (Adam Ford)
Date: Mon,  4 Sep 2017 17:12:04 -0500
Subject: [PATCH V2] ARM: dts: da850-evm: add chosen and SPI alias
Message-ID: <1504563124-25568-1-git-send-email-aford173@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch will add the chosen container to point stdout-path to serial2
and set the alias for spi0 to spi1 since the SPI NOR flash exists on SPI1.

Suggested-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Adam Ford <aford173@gmail.com>
---
Changes in V2:
  Reword the comment code without any actual change to the code.

Requires pending patch ("ARM: dts: da850-evm: add serial and ethernet aliases")

diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
index c755079..3962fa4 100644
--- a/arch/arm/boot/dts/da850-evm.dts
+++ b/arch/arm/boot/dts/da850-evm.dts
@@ -15,11 +15,16 @@
 	compatible = "ti,da850-evm", "ti,da850";
 	model = "DA850/AM1808/OMAP-L138 EVM";
 
+	chosen {
+		stdout-path = &serial2;
+	};
+
 	aliases {
 		serial0 = &serial0;
 		serial1 = &serial1;
 		serial2 = &serial2;
 		ethernet0 = &eth0;
+		spi0 = &spi1;
 	};
 
 	soc at 1c00000 {
-- 
2.7.4

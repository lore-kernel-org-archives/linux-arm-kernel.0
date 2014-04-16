From: shc_work@mail.ru (Alexander Shiyan)
Date: Wed, 16 Apr 2014 11:24:50 +0400
Subject: [PATCH 1/8] ARM: dts: i.MX51: Allow to define partitions onto NFC
Message-ID: <1397633097-1640-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch allow to define partitions onto NFC in user defined
devicetrees.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx51-digi-connectcore-som.dtsi | 2 --
 arch/arm/boot/dts/imx51.dtsi                      | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx51-digi-connectcore-som.dtsi b/arch/arm/boot/dts/imx51-digi-connectcore-som.dtsi
index 7787f46..321662f 100644
--- a/arch/arm/boot/dts/imx51-digi-connectcore-som.dtsi
+++ b/arch/arm/boot/dts/imx51-digi-connectcore-som.dtsi
@@ -195,8 +195,6 @@
 	nand-bus-width = <8>;
 	nand-ecc-mode = "hw";
 	nand-on-flash-bbt;
-	#address-cells = <1>;
-	#size-cells = <1>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index 51b8670..bebbf3b 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -538,6 +538,8 @@
 			};
 
 			nfc: nand at 83fdb000 {
+				#address-cells = <1>;
+				#size-cells = <1>;
 				compatible = "fsl,imx51-nand";
 				reg = <0x83fdb000 0x1000 0xcfff0000 0x10000>;
 				interrupts = <8>;
-- 
1.8.3.2

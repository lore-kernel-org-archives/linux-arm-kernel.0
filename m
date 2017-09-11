From: baruch@tkos.co.il (Baruch Siach)
Date: Mon, 11 Sep 2017 18:14:54 +0300
Subject: [PATCH] arm64: dts: marvell: enable AP806 watchdog
Message-ID: <b2389a76625d17cd5d7a861d004ba26c6ae7ce81.1505142894.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This watchdog is ARM SBSA generic watchdog.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
index 4d360713ed12..6687dde4f95d 100644
--- a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
@@ -241,6 +241,12 @@
 
 			};
 
+			watchdog: watchdog at 600000 {
+				compatible = "arm,sbsa-gwdt";
+				reg = <0x610000 0x1000>, <0x600000 0x1000>;
+				interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
 			ap_sdhci0: sdhci at 6e0000 {
 				compatible = "marvell,armada-ap806-sdhci";
 				reg = <0x6e0000 0x300>;
-- 
2.14.1

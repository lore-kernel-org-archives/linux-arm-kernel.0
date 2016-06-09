From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu,  9 Jun 2016 09:10:17 +0200
Subject: [PATCH 11/12] arm64: dts: marvell: add SDIO support for Armada 37xx
In-Reply-To: <1465456218-28354-1-git-send-email-gregory.clement@free-electrons.com>
References: <1465456218-28354-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1465456218-28354-12-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the SDIO support for Armada 37xx SoC and enable it in the Armada 3720
DB board.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-3720-db.dts | 6 ++++++
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi   | 8 ++++++++
 2 files changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-db.dts b/arch/arm64/boot/dts/marvell/armada-3720-db.dts
index 569756924e3e..5352d101562d 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-db.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-db.dts
@@ -78,6 +78,12 @@
 	status = "okay";
 };
 
+&sdhci1 {
+	broken-cd;
+	bus-width = <4>;
+	status = "okay";
+};
+
 /* CON31 */
 &usb3 {
 	status = "okay";
diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
index 5cc8b3f5ef51..7803ca135d37 100644
--- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
@@ -126,6 +126,14 @@
 				};
 			};
 
+			sdhci1: sdhci at d0000 {
+				compatible = "marvell,xenon-sdhci";
+				reg = <0xd0000 0x300>;
+				interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
+				auto-cmd12;
+				status = "disabled";
+			};
+
 			sdhci0: sdhci at d8000 {
 				compatible = "marvell,xenon-sdhci";
 				reg = <0xd8000 0x300>;
-- 
2.5.0

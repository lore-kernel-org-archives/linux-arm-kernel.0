From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 31 Oct 2016 12:09:57 +0100
Subject: [PATCH 8/10] arm64: dts: marvell: add eMMC support for Armada 37xx
In-Reply-To: <cover.86006f271b60cf7c0b4c5a51762a9dacca4c4718.1477911954.git-series.gregory.clement@free-electrons.com>
References: <cover.86006f271b60cf7c0b4c5a51762a9dacca4c4718.1477911954.git-series.gregory.clement@free-electrons.com>
Message-ID: <8050f9869c91cf62b7a6193d294f25fea342146a.1477911954.git-series.gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the eMMC support for Armada 37xx SoC and enable it in the Armada 3720
DB board.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-3720-db.dts |  8 ++++++++
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi   | 11 +++++++++++
 2 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-db.dts b/arch/arm64/boot/dts/marvell/armada-3720-db.dts
index 1372e9a6aaa4..9107dd3e2a44 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-db.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-db.dts
@@ -72,6 +72,14 @@
 	status = "okay";
 };
 
+&sdhci0 {
+	non-removable;
+	bus-width = <8>;
+	marvell,xenon-emmc;
+	marvell,pad-type = "fixed-1-8v";
+	status = "okay";
+};
+
 /* CON31 */
 &usb3 {
 	status = "okay";
diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
index c4762538ec01..0c4cafe92e66 100644
--- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
@@ -161,6 +161,17 @@
 				};
 			};
 
+			sdhci0: sdhci at d8000 {
+				compatible = "marvell,armada-3700-sdhci",
+				"marvell,sdhci-xenon";
+				reg = <0xd8000 0x300
+				       0x17808 0x4>;
+				interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&nb_perih_clk 0>;
+				clock-names = "core";
+				status = "disabled";
+			};
+
 			sata: sata at e0000 {
 				compatible = "marvell,armada-3700-ahci";
 				reg = <0xe0000 0x2000>;
-- 
git-series 0.8.10

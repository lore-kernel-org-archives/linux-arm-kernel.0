From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri,  7 Oct 2016 17:22:55 +0200
Subject: [PATCH 9/10] arm64: dts: marvell: add sdhci support for Armada 7K/8K
In-Reply-To: <cover.990e3503c30c18ecf50dd48bce3d52811f03ca22.1475853198.git-series.gregory.clement@free-electrons.com>
References: <cover.990e3503c30c18ecf50dd48bce3d52811f03ca22.1475853198.git-series.gregory.clement@free-electrons.com>
Message-ID: <ff336f8fe0f60df3cbfbe3f7cd54605b7c2357dd.1475853198.git-series.gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Also enable it on the Armada 7040 DB board

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-7040-db.dts |  7 +++++++
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi  |  9 +++++++++
 2 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-7040-db.dts b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
index 070b589680c5..f7f978a12a49 100644
--- a/arch/arm64/boot/dts/marvell/armada-7040-db.dts
+++ b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
@@ -146,3 +146,10 @@
 &cpm_usb3_1 {
 	status = "okay";
 };
+
+&sdhci0 {
+	status = "okay";
+	bus-width = <4>;
+	no-1-8-v;
+	non-removable;
+};
diff --git a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
index 7b6136182ad0..ef2ce6be7205 100644
--- a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
@@ -229,6 +229,15 @@
 
 			};
 
+			sdhci0: sdhci at 6e0000 {
+				compatible = "marvell,sdhci-xenon";
+				reg = <0x6e0000 0x300>;
+				interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
+				clock-names = "core";
+				clocks = <&cpm_syscon0 1 4>;
+				status = "disabled";
+			};
+
 			ap_syscon: system-controller at 6f4000 {
 				compatible = "marvell,ap806-system-controller",
 					     "syscon";
-- 
git-series 0.8.10

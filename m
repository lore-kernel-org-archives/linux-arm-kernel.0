From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 31 Oct 2016 12:09:58 +0100
Subject: [PATCH 9/10] arm64: dts: marvell: add sdhci support for Armada 7K/8K
In-Reply-To: <cover.86006f271b60cf7c0b4c5a51762a9dacca4c4718.1477911954.git-series.gregory.clement@free-electrons.com>
References: <cover.86006f271b60cf7c0b4c5a51762a9dacca4c4718.1477911954.git-series.gregory.clement@free-electrons.com>
Message-ID: <03b90e099080ebb555629386e9fb920a7639752f.1477911954.git-series.gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Also enable it on the Armada 7040 DB board

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-7040-db.dts |  8 ++++++++
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi  |  9 +++++++++
 2 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-7040-db.dts b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
index 070b589680c5..f8bdabdbd864 100644
--- a/arch/arm64/boot/dts/marvell/armada-7040-db.dts
+++ b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
@@ -146,3 +146,11 @@
 &cpm_usb3_1 {
 	status = "okay";
 };
+
+&sdhci0 {
+	status = "okay";
+	bus-width = <4>;
+	no-1-8-v;
+	non-removable;
+	marvell,xenon-emmc;
+};
diff --git a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
index 7b6136182ad0..174c41b24d4c 100644
--- a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
@@ -229,6 +229,15 @@
 
 			};
 
+			sdhci0: sdhci at 6e0000 {
+				compatible = "marvell,xenon-sdhci";
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

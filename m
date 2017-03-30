From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 30 Mar 2017 17:23:04 +0200
Subject: [PATCH v7 12/13] arm64: dts: marvell: add sdhci support for Armada
 7K/8K
In-Reply-To: <cover.51071caa64e5df81264a91b9a81ed1e94f47d2c4.1490886907.git-series.gregory.clement@free-electrons.com>
References: <cover.51071caa64e5df81264a91b9a81ed1e94f47d2c4.1490886907.git-series.gregory.clement@free-electrons.com>
Message-ID: <08d6b21af1fd65783062c14e5896700d25c602f3.1490886907.git-series.gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Also enable it on the Armada 7040 DB and Armada 8040 DB boards.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-7040-db.dts       | 14 +++++++++++++-
 arch/arm64/boot/dts/marvell/armada-8040-db.dts       | 12 +++++++++++-
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi        | 11 ++++++++++-
 arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi | 11 ++++++++++-
 4 files changed, 48 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-7040-db.dts b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
index 070b589680c5..6adbfcd26369 100644
--- a/arch/arm64/boot/dts/marvell/armada-7040-db.dts
+++ b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
@@ -146,3 +146,17 @@
 &cpm_usb3_1 {
 	status = "okay";
 };
+
+&ap_sdhci0 {
+	status = "okay";
+	bus-width = <4>;
+	no-1-8-v;
+	non-removable;
+};
+
+&cpm_sdhci0 {
+	status = "okay";
+	bus-width = <4>;
+	no-1-8-v;
+	non-removable;
+};
diff --git a/arch/arm64/boot/dts/marvell/armada-8040-db.dts b/arch/arm64/boot/dts/marvell/armada-8040-db.dts
index 6e6f182fb297..3d9565bf6e91 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-db.dts
+++ b/arch/arm64/boot/dts/marvell/armada-8040-db.dts
@@ -148,3 +148,15 @@
 &cps_usb3_1 {
 	status = "okay";
 };
+
+&ap_sdhci0 {
+	status = "okay";
+	bus-width = <4>;
+	non-removable;
+};
+
+&cpm_sdhci0 {
+	status = "okay";
+	bus-width = <8>;
+	non-removable;
+};
diff --git a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
index 5019c8f4acd0..fe41bf9c301e 100644
--- a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
@@ -229,6 +229,17 @@
 
 			};
 
+			ap_sdhci0: sdhci at 6e0000 {
+				compatible = "marvell,armada-ap806-sdhci";
+				reg = <0x6e0000 0x300>;
+				interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
+				clock-names = "core";
+				clocks = <&ap_syscon 4>;
+				dma-coherent;
+				marvell,xenon-phy-slow-mode;
+				status = "disabled";
+			};
+
 			ap_syscon: system-controller at 6f4000 {
 				compatible = "marvell,ap806-system-controller",
 					     "syscon";
diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
index 3a99c36433d6..f07ea5aeac48 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
@@ -173,6 +173,17 @@
 				clocks = <&cpm_syscon0 1 25>;
 				status = "okay";
 			};
+
+			cpm_sdhci0: sdhci at 780000 {
+				compatible = "marvell,armada-cp110-sdhci";
+				reg = <0x780000 0x300>;
+				interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
+				clock-names = "core";
+				clocks = <&cpm_syscon0 1 4>;
+				dma-coherent;
+				status = "disabled";
+			};
+
 		};
 
 		cpm_pcie0: pcie at f2600000 {
-- 
git-series 0.9.1

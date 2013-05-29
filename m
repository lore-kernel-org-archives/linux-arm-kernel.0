From: csd@broadcom.com (Christian Daudt)
Date: Wed, 29 May 2013 13:50:07 -0700
Subject: [PATCH V4 3/3] ARM: mmc: bcm281xx SDHCI driver (dt mods)
In-Reply-To: <1369860607-25572-1-git-send-email-csd@broadcom.com>
References: <1369860607-25572-1-git-send-email-csd@broadcom.com>
Message-ID: <1369860607-25572-3-git-send-email-csd@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add SDHCI bindings for the Broadcom 281xx SoCs.

Changes from V2:
 - Documentation cleanups

Changes from V1:
 - split original patch into 2, one for driver and this one for dt

Signed-off-by: Christian Daudt <csd@broadcom.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/Documentation/devicetree/bindings/mmc/bcm,kona-sdhci.txt b/Documentation/devicetree/bindings/mmc/bcm,kona-sdhci.txt
new file mode 100644
index 0000000..094ae01
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/bcm,kona-sdhci.txt
@@ -0,0 +1,16 @@
+Broadcom BCM281xx SDHCI
+
+This file documents differences between the core properties in mmc.txt
+and the properties present in the bcm281xx SDHCI
+
+Required properties:
+- compatible : Should be "bcm,kona-sdhci"
+
+Example:
+
+sdio2: sdio at 0x3f1a0000 {
+	compatible = "bcm,kona-sdhci";
+	reg = <0x3f1a0000 0x10000>;
+	interrupts = <0x0 74 0x4>;
+};
+
diff --git a/arch/arm/boot/dts/bcm11351-brt.dts b/arch/arm/boot/dts/bcm11351-brt.dts
index 248067c..9ae3404 100644
--- a/arch/arm/boot/dts/bcm11351-brt.dts
+++ b/arch/arm/boot/dts/bcm11351-brt.dts
@@ -27,4 +27,21 @@
 		status = "okay";
 	};
 
+	sdio0: sdio at 0x3f180000 {
+		max-frequency = <48000000>;
+		status = "okay";
+	};
+
+	sdio1: sdio at 0x3f190000 {
+		non-removable;
+		max-frequency = <48000000>;
+		status = "okay";
+	};
+
+	sdio3: sdio at 0x3f1b0000 {
+		max-frequency = <48000000>;
+		status = "okay";
+	};
+
+
 };
diff --git a/arch/arm/boot/dts/bcm11351.dtsi b/arch/arm/boot/dts/bcm11351.dtsi
index 41b2c6c..39de6e2 100644
--- a/arch/arm/boot/dts/bcm11351.dtsi
+++ b/arch/arm/boot/dts/bcm11351.dtsi
@@ -60,4 +60,32 @@
 		clock-frequency = <32768>;
 	};
 
+	sdio0: sdio at 0x3f180000 {
+		compatible = "bcm,kona-sdhci";
+		reg = <0x3f180000 0x10000>;
+		interrupts = <0x0 77 0x4>;
+		status = "disabled";
+	};
+
+	sdio1: sdio at 0x3f190000 {
+		compatible = "bcm,kona-sdhci";
+		reg = <0x3f190000 0x10000>;
+		interrupts = <0x0 76 0x4>;
+		status = "disabled";
+	};
+
+	sdio2: sdio at 0x3f1a0000 {
+		compatible = "bcm,kona-sdhci";
+		reg = <0x3f1a0000 0x10000>;
+		interrupts = <0x0 74 0x4>;
+		status = "disabled";
+	};
+
+	sdio3: sdio at 0x3f1b0000 {
+		compatible = "bcm,kona-sdhci";
+		reg = <0x3f1b0000 0x10000>;
+		interrupts = <0x0 73 0x4>;
+		status = "disabled";
+	};
+
 };
-- 
1.7.10.4

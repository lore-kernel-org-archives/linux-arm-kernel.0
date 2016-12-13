From: jon.mason@broadcom.com (Jon Mason)
Date: Tue, 13 Dec 2016 13:13:47 -0500
Subject: [PATCH 3/7] ARM: dts: NSP: Add QSPI support to missing boards
In-Reply-To: <1481652831-2744-1-git-send-email-jon.mason@broadcom.com>
References: <1481652831-2744-1-git-send-email-jon.mason@broadcom.com>
Message-ID: <1481652831-2744-4-git-send-email-jon.mason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

QSPI device tree entries are present in bcm958625k, but missing from
bcm958522er, bcm958525er, bcm958525xmc, bcm958622hr, bcm958623hr,
bcm958625hr, and bcm988312hr.  Duplicate the entry in bcm958625k for
all of those that are missing it (as they are identical).

Signed-off-by: Jon Mason <jon.mason@broadcom.com>
---
 arch/arm/boot/dts/bcm958522er.dts  | 34 ++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/bcm958525er.dts  | 34 ++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/bcm958525xmc.dts | 34 ++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/bcm958622hr.dts  | 34 ++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/bcm958623hr.dts  | 34 ++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/bcm958625hr.dts  | 34 ++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/bcm988312hr.dts  | 34 ++++++++++++++++++++++++++++++++++
 7 files changed, 238 insertions(+)

diff --git a/arch/arm/boot/dts/bcm958522er.dts b/arch/arm/boot/dts/bcm958522er.dts
index 7afd845..3f04a40 100644
--- a/arch/arm/boot/dts/bcm958522er.dts
+++ b/arch/arm/boot/dts/bcm958522er.dts
@@ -124,6 +124,40 @@
 	};
 };
 
+&qspi {
+	bspi-sel = <0>;
+	flash: m25p80 at 0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "m25p80";
+		reg = <0x0>;
+		spi-max-frequency = <12500000>;
+		m25p,fast-read;
+		spi-cpol;
+		spi-cpha;
+
+		partition at 0 {
+			label = "boot";
+			reg = <0x00000000 0x000a0000>;
+		};
+
+		partition at a0000 {
+			label = "env";
+			reg = <0x000a0000 0x00060000>;
+		};
+
+		partition at 100000 {
+			label = "system";
+			reg = <0x00100000 0x00600000>;
+		};
+
+		partition at 700000 {
+			label = "rootfs";
+			reg = <0x00700000 0x01900000>;
+		};
+	};
+};
+
 &uart0 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/bcm958525er.dts b/arch/arm/boot/dts/bcm958525er.dts
index 9da18cd..9fd5422 100644
--- a/arch/arm/boot/dts/bcm958525er.dts
+++ b/arch/arm/boot/dts/bcm958525er.dts
@@ -124,6 +124,40 @@
 	};
 };
 
+&qspi {
+	bspi-sel = <0>;
+	flash: m25p80 at 0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "m25p80";
+		reg = <0x0>;
+		spi-max-frequency = <12500000>;
+		m25p,fast-read;
+		spi-cpol;
+		spi-cpha;
+
+		partition at 0 {
+			label = "boot";
+			reg = <0x00000000 0x000a0000>;
+		};
+
+		partition at a0000 {
+			label = "env";
+			reg = <0x000a0000 0x00060000>;
+		};
+
+		partition at 100000 {
+			label = "system";
+			reg = <0x00100000 0x00600000>;
+		};
+
+		partition at 700000 {
+			label = "rootfs";
+			reg = <0x00700000 0x01900000>;
+		};
+	};
+};
+
 &sata_phy0 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/bcm958525xmc.dts b/arch/arm/boot/dts/bcm958525xmc.dts
index 4492f55..89d9abc 100644
--- a/arch/arm/boot/dts/bcm958525xmc.dts
+++ b/arch/arm/boot/dts/bcm958525xmc.dts
@@ -134,6 +134,40 @@
 	};
 };
 
+&qspi {
+	bspi-sel = <0>;
+	flash: m25p80 at 0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "m25p80";
+		reg = <0x0>;
+		spi-max-frequency = <12500000>;
+		m25p,fast-read;
+		spi-cpol;
+		spi-cpha;
+
+		partition at 0 {
+			label = "boot";
+			reg = <0x00000000 0x000a0000>;
+		};
+
+		partition at a0000 {
+			label = "env";
+			reg = <0x000a0000 0x00060000>;
+		};
+
+		partition at 100000 {
+			label = "system";
+			reg = <0x00100000 0x00600000>;
+		};
+
+		partition at 700000 {
+			label = "rootfs";
+			reg = <0x00700000 0x01900000>;
+		};
+	};
+};
+
 &sata_phy0 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/bcm958622hr.dts b/arch/arm/boot/dts/bcm958622hr.dts
index ad2aa87..18b8ffb 100644
--- a/arch/arm/boot/dts/bcm958622hr.dts
+++ b/arch/arm/boot/dts/bcm958622hr.dts
@@ -120,6 +120,40 @@
 	};
 };
 
+&qspi {
+	bspi-sel = <0>;
+	flash: m25p80 at 0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "m25p80";
+		reg = <0x0>;
+		spi-max-frequency = <12500000>;
+		m25p,fast-read;
+		spi-cpol;
+		spi-cpha;
+
+		partition at 0 {
+			label = "boot";
+			reg = <0x00000000 0x000a0000>;
+		};
+
+		partition at a0000 {
+			label = "env";
+			reg = <0x000a0000 0x00060000>;
+		};
+
+		partition at 100000 {
+			label = "system";
+			reg = <0x00100000 0x00600000>;
+		};
+
+		partition at 700000 {
+			label = "rootfs";
+			reg = <0x00700000 0x01900000>;
+		};
+	};
+};
+
 &srab {
 	compatible = "brcm,bcm58622-srab", "brcm,nsp-srab";
 	status = "okay";
diff --git a/arch/arm/boot/dts/bcm958623hr.dts b/arch/arm/boot/dts/bcm958623hr.dts
index 32ea59a..61499ae 100644
--- a/arch/arm/boot/dts/bcm958623hr.dts
+++ b/arch/arm/boot/dts/bcm958623hr.dts
@@ -128,6 +128,40 @@
 	status = "okay";
 };
 
+&qspi {
+	bspi-sel = <0>;
+	flash: m25p80 at 0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "m25p80";
+		reg = <0x0>;
+		spi-max-frequency = <12500000>;
+		m25p,fast-read;
+		spi-cpol;
+		spi-cpha;
+
+		partition at 0 {
+			label = "boot";
+			reg = <0x00000000 0x000a0000>;
+		};
+
+		partition at a0000 {
+			label = "env";
+			reg = <0x000a0000 0x00060000>;
+		};
+
+		partition at 100000 {
+			label = "system";
+			reg = <0x00100000 0x00600000>;
+		};
+
+		partition at 700000 {
+			label = "rootfs";
+			reg = <0x00700000 0x01900000>;
+		};
+	};
+};
+
 &srab {
 	compatible = "brcm,bcm58623-srab", "brcm,nsp-srab";
 	status = "okay";
diff --git a/arch/arm/boot/dts/bcm958625hr.dts b/arch/arm/boot/dts/bcm958625hr.dts
index e7a4cb1..94cce23 100644
--- a/arch/arm/boot/dts/bcm958625hr.dts
+++ b/arch/arm/boot/dts/bcm958625hr.dts
@@ -118,6 +118,40 @@
 	};
 };
 
+&qspi {
+	bspi-sel = <0>;
+	flash: m25p80 at 0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "m25p80";
+		reg = <0x0>;
+		spi-max-frequency = <12500000>;
+		m25p,fast-read;
+		spi-cpol;
+		spi-cpha;
+
+		partition at 0 {
+			label = "boot";
+			reg = <0x00000000 0x000a0000>;
+		};
+
+		partition at a0000 {
+			label = "env";
+			reg = <0x000a0000 0x00060000>;
+		};
+
+		partition at 100000 {
+			label = "system";
+			reg = <0x00100000 0x00600000>;
+		};
+
+		partition at 700000 {
+			label = "rootfs";
+			reg = <0x00700000 0x01900000>;
+		};
+	};
+};
+
 &sata_phy0 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/bcm988312hr.dts b/arch/arm/boot/dts/bcm988312hr.dts
index 104afe9..c324c9f 100644
--- a/arch/arm/boot/dts/bcm988312hr.dts
+++ b/arch/arm/boot/dts/bcm988312hr.dts
@@ -120,6 +120,40 @@
 	};
 };
 
+&qspi {
+	bspi-sel = <0>;
+	flash: m25p80 at 0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "m25p80";
+		reg = <0x0>;
+		spi-max-frequency = <12500000>;
+		m25p,fast-read;
+		spi-cpol;
+		spi-cpha;
+
+		partition at 0 {
+			label = "boot";
+			reg = <0x00000000 0x000a0000>;
+		};
+
+		partition at a0000 {
+			label = "env";
+			reg = <0x000a0000 0x00060000>;
+		};
+
+		partition at 100000 {
+			label = "system";
+			reg = <0x00100000 0x00600000>;
+		};
+
+		partition at 700000 {
+			label = "rootfs";
+			reg = <0x00700000 0x01900000>;
+		};
+	};
+};
+
 &sata_phy0 {
 	status = "okay";
 };
-- 
2.7.4

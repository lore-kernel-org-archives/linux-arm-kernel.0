From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 01 Oct 2013 19:33:43 +0900
Subject: [PATCH 05/05] ARM: shmobile: Remove KDM9D reference DTS
In-Reply-To: <20131001103255.813.65710.sendpatchset@w520>
References: <20131001103255.813.65710.sendpatchset@w520>
Message-ID: <20131001103343.813.54921.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Now when the legacy DTS file emev2-kzm9d.dts can be
used with board-kzm9d.c and board-kzm9d-reference.c
proceed with removing emev-kzm9d-reference.dts.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/boot/dts/Makefile                  |    3 -
 arch/arm/boot/dts/emev2-kzm9d-reference.dts |   57 ---------------------------
 2 files changed, 1 insertion(+), 59 deletions(-)

--- 0001/arch/arm/boot/dts/Makefile
+++ work/arch/arm/boot/dts/Makefile	2013-10-01 18:53:19.000000000 +0900
@@ -195,7 +195,6 @@ dtb-$(CONFIG_ARCH_U8500) += ste-snowball
 	ste-ccu9540.dtb
 dtb-$(CONFIG_ARCH_S3C24XX) += s3c2416-smdk2416.dtb
 dtb-$(CONFIG_ARCH_SHMOBILE) += emev2-kzm9d.dtb \
-	emev2-kzm9d-reference.dtb \
 	r8a7740-armadillo800eva.dtb \
 	r8a7778-bockw.dtb \
 	r8a7778-bockw-reference.dtb \
@@ -210,7 +209,7 @@ dtb-$(CONFIG_ARCH_SHMOBILE) += emev2-kzm
 	r8a73a4-ape6evm.dtb \
 	r8a73a4-ape6evm-reference.dtb \
 	sh7372-mackerel.dtb
-dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += emev2-kzm9d-reference.dtb
+dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += emev2-kzm9d.dtb
 dtb-$(CONFIG_ARCH_SOCFPGA) += socfpga_cyclone5.dtb \
 	socfpga_vt.dtb
 dtb-$(CONFIG_ARCH_SPEAR13XX) += spear1310-evb.dtb \
--- 0001/arch/arm/boot/dts/emev2-kzm9d-reference.dts
+++ /dev/null	2013-06-03 21:41:10.638032047 +0900
@@ -1,57 +0,0 @@
-/*
- * Device Tree Source for the KZM9D board
- *
- * Copyright (C) 2013 Renesas Solutions Corp.
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
- */
-/dts-v1/;
-
-/include/ "emev2.dtsi"
-
-/ {
-	model = "EMEV2 KZM9D Board";
-	compatible = "renesas,kzm9d-reference", "renesas,emev2";
-
-	memory {
-		device_type = "memory";
-		reg = <0x40000000 0x8000000>;
-	};
-
-	chosen {
-		bootargs = "console=ttyS1,115200n81 ignore_loglevel root=/dev/nfs ip=dhcp";
-	};
-
-	reg_1p8v: regulator at 0 {
-		compatible = "regulator-fixed";
-		regulator-name = "fixed-1.8V";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-		regulator-always-on;
-		regulator-boot-on;
-	};
-
-	reg_3p3v: regulator at 1 {
-		compatible = "regulator-fixed";
-		regulator-name = "fixed-3.3V";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		regulator-always-on;
-		regulator-boot-on;
-	};
-
-	lan9220 at 20000000 {
-		compatible = "smsc,lan9220", "smsc,lan9115";
-		reg = <0x20000000 0x10000>;
-		phy-mode = "mii";
-		interrupt-parent = <&gpio0>;
-		interrupts = <1 1>;	/* active high */
-		reg-io-width = <4>;
-		smsc,irq-active-high;
-		smsc,irq-push-pull;
-		vddvario-supply = <&reg_1p8v>;
-		vdd33a-supply = <&reg_3p3v>;
-	};
-};

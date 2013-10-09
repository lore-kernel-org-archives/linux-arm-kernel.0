From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  9 Oct 2013 15:51:03 +0900
Subject: [PATCH 11/14] ARM: shmobile: Remove KZM9D reference DTS
In-Reply-To: <cover.1381299817.git.horms+renesas@verge.net.au>
References: <cover.1381299817.git.horms+renesas@verge.net.au>
Message-ID: <3d888121512f3d70b46ff67d02b41baf474a3123.1381299817.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Now when the legacy DTS file emev2-kzm9d.dts can be
used with board-kzm9d.c and board-kzm9d-reference.c
proceed with removing emev-kzm9d-reference.dts.

Signed-off-by: Magnus Damm <damm@opensource.se>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/Makefile                  |  3 +-
 arch/arm/boot/dts/emev2-kzm9d-reference.dts | 57 -----------------------------
 2 files changed, 1 insertion(+), 59 deletions(-)
 delete mode 100644 arch/arm/boot/dts/emev2-kzm9d-reference.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 295824d..a72a9f4 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -195,7 +195,6 @@ dtb-$(CONFIG_ARCH_U8500) += ste-snowball.dtb \
 	ste-ccu9540.dtb
 dtb-$(CONFIG_ARCH_S3C24XX) += s3c2416-smdk2416.dtb
 dtb-$(CONFIG_ARCH_SHMOBILE) += emev2-kzm9d.dtb \
-	emev2-kzm9d-reference.dtb \
 	r7s72100-genmai.dtb \
 	r8a7740-armadillo800eva.dtb \
 	r8a7778-bockw.dtb \
@@ -211,7 +210,7 @@ dtb-$(CONFIG_ARCH_SHMOBILE) += emev2-kzm9d.dtb \
 	r8a73a4-ape6evm.dtb \
 	r8a73a4-ape6evm-reference.dtb \
 	sh7372-mackerel.dtb
-dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += emev2-kzm9d-reference.dtb
+dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += emev2-kzm9d.dtb
 dtb-$(CONFIG_ARCH_SOCFPGA) += socfpga_cyclone5.dtb \
 	socfpga_vt.dtb
 dtb-$(CONFIG_ARCH_SPEAR13XX) += spear1310-evb.dtb \
diff --git a/arch/arm/boot/dts/emev2-kzm9d-reference.dts b/arch/arm/boot/dts/emev2-kzm9d-reference.dts
deleted file mode 100644
index cceefda..0000000
--- a/arch/arm/boot/dts/emev2-kzm9d-reference.dts
+++ /dev/null
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
-- 
1.8.4

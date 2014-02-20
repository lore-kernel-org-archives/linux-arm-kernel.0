From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 20 Feb 2014 15:57:19 +0100
Subject: [PATCH v2 2/2] ARM: shmobile: bockw reference dts: Add SPI FLASH
In-Reply-To: <1392908239-22645-1-git-send-email-geert@linux-m68k.org>
References: <1392908239-22645-1-git-send-email-geert@linux-m68k.org>
Message-ID: <1392908239-22645-2-git-send-email-geert@linux-m68k.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Add Spansion s25fl008k SPI FLASH and MTD partition, based on bockw legacy
board code.

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
Tested-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v2:
  - Add Tested-by

 arch/arm/boot/dts/r8a7778-bockw-reference.dts |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7778-bockw-reference.dts b/arch/arm/boot/dts/r8a7778-bockw-reference.dts
index 06cda19dac6a..f76f6ec01e19 100644
--- a/arch/arm/boot/dts/r8a7778-bockw-reference.dts
+++ b/arch/arm/boot/dts/r8a7778-bockw-reference.dts
@@ -109,4 +109,18 @@
 	pinctrl-0 = <&hspi0_pins>;
 	pinctrl-names = "default";
 	status = "okay";
+
+	flash: flash at 0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "spansion,s25fl008k";
+		reg = <0>;
+		spi-max-frequency = <104000000>;
+		m25p,fast-read;
+
+		partition at 0 {
+			label = "data(spi)";
+			reg = <0x00000000 0x00100000>;
+		};
+	};
 };
-- 
1.7.9.5

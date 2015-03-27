From: jbe@pengutronix.de (Juergen Borleis)
Date: Fri, 27 Mar 2015 11:22:30 +0100
Subject: ARM: dts: Fix wrong SoC type to build devicetrees for i.MX27
Message-ID: <201503271122.30489.jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch cb612390e5469 "Only build dtb if associated Arch and/or SoC is enabled"
uses the wrong SoC name which prevents i.MX27 related devicetrees
from build.
    
Signed-off-by: Juergen Borleis <jbe@pengutronix.de>

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index a1c776b8dcec..992ea0b063d5 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -215,7 +215,7 @@ dtb-$(CONFIG_SOC_IMX25) += \
 	imx25-eukrea-mbimxsd25-baseboard-dvi-vga.dtb \
 	imx25-karo-tx25.dtb \
 	imx25-pdk.dtb
-dtb-$(CONFIG_SOC_IMX31) += \
+dtb-$(CONFIG_SOC_IMX27) += \
 	imx27-apf27.dtb \
 	imx27-apf27dev.dtb \
 	imx27-eukrea-mbimxsd27-baseboard.dtb \

From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 19 May 2015 22:13:46 +0800
Subject: [PATCH] ARM: dts: fix imx27 dtb build rule
Message-ID: <1432044826-6629-1-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Guo <shawn.guo@linaro.org>

The i.MX27 dtb build should be controlled by CONFIG_SOC_IMX27 rather
than CONFIG_SOC_IMX31.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Fixes: cb612390e546 ("ARM: dts: Only build dtb if associated Arch and/or SoC is enabled")
Cc: <stable@vger.kernel.org>
---
 arch/arm/boot/dts/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 86217db2937a..992736b5229b 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -223,7 +223,7 @@ dtb-$(CONFIG_SOC_IMX25) += \
 	imx25-eukrea-mbimxsd25-baseboard-dvi-vga.dtb \
 	imx25-karo-tx25.dtb \
 	imx25-pdk.dtb
-dtb-$(CONFIG_SOC_IMX31) += \
+dtb-$(CONFIG_SOC_IMX27) += \
 	imx27-apf27.dtb \
 	imx27-apf27dev.dtb \
 	imx27-eukrea-mbimxsd27-baseboard.dtb \
-- 
1.9.1

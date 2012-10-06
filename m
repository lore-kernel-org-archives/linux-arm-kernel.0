From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat,  6 Oct 2012 21:49:45 +0800
Subject: [PATCH] ARM: dts: remove redundant imx dtb targets from Makefile
Message-ID: <1349531385-23961-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We already have CONFIG_ARCH_MXC cover imx5 and imx6 dtb targets.
Remove the redundant ones with CONFIG_ARCH_IMX5 and CONFIG_SOC_IMX6Q.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
Olof,

Most likely, it's a merge problem eventually showing on manline.
Please send the fix for 3.7-rc.

Shawn

 arch/arm/boot/dts/Makefile |    8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 43c084c..fe39ac1 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -22,14 +22,6 @@ dtb-$(CONFIG_ARCH_EXYNOS) += exynos4210-origen.dtb \
 	exynos4210-trats.dtb \
 	exynos5250-smdk5250.dtb
 dtb-$(CONFIG_ARCH_HIGHBANK) += highbank.dtb
-dtb-$(CONFIG_ARCH_IMX5) += imx51-babbage.dtb \
-	imx53-ard.dtb \
-	imx53-evk.dtb \
-	imx53-qsb.dtb \
-	imx53-smd.dtb
-dtb-$(CONFIG_SOC_IMX6Q) += imx6q-arm2.dtb \
-	imx6q-sabrelite.dtb \
-	imx6q-sabresd.dtb
 dtb-$(CONFIG_ARCH_LPC32XX) += ea3250.dtb phy3250.dtb
 dtb-$(CONFIG_ARCH_KIRKWOOD) += kirkwood-dns320.dtb \
 	kirkwood-dns325.dtb \
-- 
1.7.9.5

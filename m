From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 31 Jan 2012 15:38:10 +0800
Subject: [PATCH] ARM: imx5: generate dtbs for imx5 boards
Message-ID: <1327995490-10322-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It helps to generate device tree blobs for imx5 boards with command
'make ARCH=arm dtbs'.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/Makefile.boot |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-imx/Makefile.boot b/arch/arm/mach-imx/Makefile.boot
index 6dfdbcc..3851d8a 100644
--- a/arch/arm/mach-imx/Makefile.boot
+++ b/arch/arm/mach-imx/Makefile.boot
@@ -38,5 +38,8 @@ zreladdr-$(CONFIG_SOC_IMX6Q)	+= 0x10008000
 params_phys-$(CONFIG_SOC_IMX6Q)	:= 0x10000100
 initrd_phys-$(CONFIG_SOC_IMX6Q)	:= 0x10800000
 
+dtb-$(CONFIG_MACH_IMX51_DT) += imx51-babbage.dtb
+dtb-$(CONFIG_MACH_IMX53_DT) += imx53-ard.dtb imx53-evk.dtb \
+			       imx53-qsb.dtb imx53-smd.dtb
 dtb-$(CONFIG_SOC_IMX6Q)	+= imx6q-arm2.dtb \
 			   imx6q-sabrelite.dtb
-- 
1.7.5.4

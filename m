From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Sun, 22 Jul 2012 23:48:17 +0200
Subject: [PATCH] ARM: mxs: enable ocotp on imx23 and imx28
Message-ID: <1342993697-25875-1-git-send-email-mkl@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds ocotp support to imx23 and imx28, a dt-only kernel fails
to link with this error message otherwise:

arch/arm/mach-mxs/mach-mxs.c:169: undefined reference to `mxs_get_ocotp'

Cc: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Hello Shawn,

this applies to your "mxs/dt-for-3.6" tree. According to the datasheet
both processors have a ocotp unit. Hope it alright to select the OCOTP
on both imx23 and imx28.

regards, Marc

 arch/arm/mach-mxs/Kconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-mxs/Kconfig b/arch/arm/mach-mxs/Kconfig
index ccdf83b..9dd743e 100644
--- a/arch/arm/mach-mxs/Kconfig
+++ b/arch/arm/mach-mxs/Kconfig
@@ -10,6 +10,7 @@ config SOC_IMX23
 	select ARM_AMBA
 	select CPU_ARM926T
 	select HAVE_PWM
+	select MXS_OCOTP
 	select PINCTRL_IMX23
 
 config SOC_IMX28
@@ -18,6 +19,7 @@ config SOC_IMX28
 	select CPU_ARM926T
 	select HAVE_CAN_FLEXCAN if CAN
 	select HAVE_PWM
+	select MXS_OCOTP
 	select PINCTRL_IMX28
 
 comment "MXS platforms:"
-- 
1.7.10.4

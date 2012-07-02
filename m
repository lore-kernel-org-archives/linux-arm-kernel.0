From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Mon,  2 Jul 2012 11:03:00 +0200
Subject: [PATCH v2 1/2] arm: imx: enable flexcan on imx25, imx35, imx53, imx6q
In-Reply-To: <1341219781-26107-1-git-send-email-mkl@pengutronix.de>
References: <1341219781-26107-1-git-send-email-mkl@pengutronix.de>
Message-ID: <1341219781-26107-2-git-send-email-mkl@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Aas the flexcan driver has DT binding for some time now. This patch makes
the flexcan driver available in the can drivers menu if a SOC with flexcan
is enabled.

Cc: Sascha Hauer <sha@pengutronix.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 arch/arm/mach-imx/Kconfig |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index eff4db5..c296851 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -52,6 +52,7 @@ config SOC_IMX25
 	select ARCH_MX25
 	select COMMON_CLK
 	select CPU_ARM926T
+	select HAVE_CAN_FLEXCAN if CAN
 	select ARCH_MXC_IOMUX_V3
 	select MXC_AVIC
 
@@ -79,6 +80,7 @@ config SOC_IMX35
 	select HAVE_EPIT
 	select MXC_AVIC
 	select SMP_ON_UP if SMP
+	select HAVE_CAN_FLEXCAN if CAN
 
 config SOC_IMX5
 	select CPU_V7
@@ -105,6 +107,7 @@ config	SOC_IMX53
 	select SOC_IMX5
 	select ARCH_MX5
 	select ARCH_MX53
+	select HAVE_CAN_FLEXCAN if CAN
 
 if ARCH_IMX_V4_V5
 
@@ -826,6 +829,7 @@ config SOC_IMX6Q
 	select COMMON_CLK
 	select CPU_V7
 	select HAVE_ARM_SCU
+	select HAVE_CAN_FLEXCAN if CAN
 	select HAVE_IMX_GPC
 	select HAVE_IMX_MMDC
 	select HAVE_IMX_SRC
-- 
1.7.10

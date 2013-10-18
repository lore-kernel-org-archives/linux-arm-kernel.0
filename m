From: gerg@uclinux.org (gerg at uclinux.org)
Date: Fri, 18 Oct 2013 16:04:17 +1000
Subject: [PATCH 5/8] ARM: imx: allow configuration of the IMX50 SoC
In-Reply-To: <1382076260-6422-1-git-send-email-gerg@uclinux.org>
References: <1382076260-6422-1-git-send-email-gerg@uclinux.org>
Message-ID: <1382076260-6422-6-git-send-email-gerg@uclinux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Greg Ungerer <gerg@uclinux.org>

Allow the Freescale IMX50 SoC support code to be configured on.

Signed-off-by: Greg Ungerer <gerg@uclinux.org>
---
 arch/arm/mach-imx/Kconfig | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 29a8af6..8497b26 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -772,6 +772,15 @@ endchoice
 
 comment "Device tree only"
 
+config	SOC_IMX50
+	bool "i.MX50 support"
+	select HAVE_IMX_SRC
+	select IMX_HAVE_PLATFORM_IMX2_WDT
+	select SOC_IMX5
+
+	help
+	  This enables support for Freescale i.MX50 processor.
+
 config	SOC_IMX53
 	bool "i.MX53 support"
 	select HAVE_IMX_SRC
-- 
1.8.1.4

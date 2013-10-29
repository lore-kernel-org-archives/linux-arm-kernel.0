From: gerg@uclinux.org (gerg at uclinux.org)
Date: Tue, 29 Oct 2013 15:15:54 +1000
Subject: [PATCHv2 4/7] ARM: imx: allow configuration of the IMX50 SoC
In-Reply-To: <1383023757-30711-1-git-send-email-gerg@uclinux.org>
References: <1383023757-30711-1-git-send-email-gerg@uclinux.org>
Message-ID: <1383023757-30711-5-git-send-email-gerg@uclinux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Greg Ungerer <gerg@uclinux.org>

Allow the Freescale IMX50 SoC support code to be configured on.

Signed-off-by: Greg Ungerer <gerg@uclinux.org>
---
 arch/arm/mach-imx/Kconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 270f786..604d18b 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -773,6 +773,14 @@ endchoice
 
 comment "Device tree only"
 
+config	SOC_IMX50
+	bool "i.MX50 support"
+	select HAVE_IMX_SRC
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

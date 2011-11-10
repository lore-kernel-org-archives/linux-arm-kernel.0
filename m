From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 10 Nov 2011 16:39:31 +0800
Subject: [PATCH 3/4] arm/imx: fix AUTO_ZRELADDR selection
In-Reply-To: <1320914372-4416-1-git-send-email-shawn.guo@linaro.org>
References: <1320914372-4416-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1320914372-4416-4-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The AUTO_ZRELADDR selection for ARCH_IMX_V4_V5 and ARCH_MX5 should
really be mutually exclusive to ZBOOT_ROM just like what ARCH_IMX_V6_V7
does.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/plat-mxc/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-mxc/Kconfig b/arch/arm/plat-mxc/Kconfig
index a08a951..b3a1f2b 100644
--- a/arch/arm/plat-mxc/Kconfig
+++ b/arch/arm/plat-mxc/Kconfig
@@ -10,7 +10,7 @@ choice
 
 config ARCH_IMX_V4_V5
 	bool "i.MX1, i.MX21, i.MX25, i.MX27"
-	select AUTO_ZRELADDR
+	select AUTO_ZRELADDR if !ZBOOT_ROM
 	select ARM_PATCH_PHYS_VIRT
 	help
 	  This enables support for systems based on the Freescale i.MX ARMv4
@@ -26,7 +26,7 @@ config ARCH_IMX_V6_V7
 
 config ARCH_MX5
 	bool "i.MX50, i.MX51, i.MX53"
-	select AUTO_ZRELADDR
+	select AUTO_ZRELADDR if !ZBOOT_ROM
 	select ARM_PATCH_PHYS_VIRT
 	help
 	  This enables support for machines using Freescale's i.MX50 and i.MX53
-- 
1.7.4.1

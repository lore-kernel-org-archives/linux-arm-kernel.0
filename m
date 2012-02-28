From: heiko@sntech.de (Heiko =?iso-8859-15?q?St=FCbner?=)
Date: Tue, 28 Feb 2012 22:34:16 +0100
Subject: [PATCH] Move S3C2412_PM_SLEEP to common platform code
In-Reply-To: <1329346545-16373-9-git-send-email-kgene.kim@samsung.com>
References: <1329346545-16373-1-git-send-email-kgene.kim@samsung.com>
 <1329346545-16373-9-git-send-email-kgene.kim@samsung.com>
Message-ID: <201202282234.17056.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

S3C2412_PM_SLEEP is also used by the S3C2416, so move it out of the
if CPU_S3C2412 block to the common platform code to prevent warnings
when S3C2416_PM is selected but not CPU_S3C2412.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
this should probably be folded into the S3C2412 move patch

 arch/arm/mach-s3c24xx/Kconfig |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/Kconfig b/arch/arm/mach-s3c24xx/Kconfig
index 599e025..158958c 100644
--- a/arch/arm/mach-s3c24xx/Kconfig
+++ b/arch/arm/mach-s3c24xx/Kconfig
@@ -83,6 +83,12 @@ config CPU_S3C2443
 
 comment "S3C24XX base platform code"
 
+config S3C2412_PM_SLEEP
+	bool
+	help
+	  Internal config node to apply sleep for S3C2412 power management.
+	  Can be selected by another SoCs with similar sleep procedure.
+
 config S3C24XX_DMA
 	bool "S3C2410 DMA support"
 	depends on ARCH_S3C24XX
@@ -253,12 +259,6 @@ config S3C2412_PM
 	help
 	  Internal config node to apply S3C2412 power management
 
-config S3C2412_PM_SLEEP
-	bool
-	help
-	  Internal config node to apply sleep for S3C2412 power management.
-	  Can be selected by another SoCs with similar sleep procedure.
-
 comment "S3C2412 Boards"
 
 #
-- 
1.7.2.3

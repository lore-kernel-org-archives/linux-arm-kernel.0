From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Tue, 5 Feb 2013 22:51:16 +0100
Subject: [PATCH] ARM: S3C24XX: let S3C2412_PM select S3C2412_PM_SLEEP
Message-ID: <201302052251.17152.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The code to enter sleep is used by both the s3c2412 and s3c2416 and
was thus factored out into an extra config option.

But it seems it was forgotten to add the appropriate select to the
s3c2412 pm option, resulting in breakage when only compiling s3c2412
support.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/mach-s3c24xx/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-s3c24xx/Kconfig b/arch/arm/mach-s3c24xx/Kconfig
index 5e17e1d..ac61bb7 100644
--- a/arch/arm/mach-s3c24xx/Kconfig
+++ b/arch/arm/mach-s3c24xx/Kconfig
@@ -301,6 +301,7 @@ config S3C2412_DMA
 
 config S3C2412_PM
 	bool
+	select S3C2412_PM_SLEEP
 	help
 	  Internal config node to apply S3C2412 power management
 
-- 
1.7.10.4

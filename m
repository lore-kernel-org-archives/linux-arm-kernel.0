From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 12 Feb 2015 20:35:44 +0100
Subject: [PATCH 7/9] ARM: s3c24xx: avoid a Kconfig warning
In-Reply-To: <1423769746-582629-1-git-send-email-arnd@arndb.de>
References: <1423769746-582629-1-git-send-email-arnd@arndb.de>
Message-ID: <1423769746-582629-8-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PM_H1940 symbol is used by two platforms: RX3715 and RX1950. However,
it is hidden inside of the the CPU_S3C2410 conditional, which is only
set by one of them, so we get a lot of randconfig warnings like

warning: (MACH_RX3715 && MACH_RX1950) selects PM_H1940 which has unmet direct dependencies (ARCH_S3C24XX && CPU_S3C2410)

This moves it outside of the conditional to remove the warnings.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-s3c24xx/Kconfig | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/Kconfig b/arch/arm/mach-s3c24xx/Kconfig
index a6d3b5bcc4c2..23bec3a85b22 100644
--- a/arch/arm/mach-s3c24xx/Kconfig
+++ b/arch/arm/mach-s3c24xx/Kconfig
@@ -228,11 +228,6 @@ config H1940BT
 	  This is a simple driver that is able to control
 	  the state of built in bluetooth chip on h1940.
 
-config PM_H1940
-	bool
-	help
-	  Internal node for H1940 and related PM
-
 config MACH_N30
 	bool "Acer N30 family"
 	select S3C_DEV_NAND
@@ -585,6 +580,11 @@ config MACH_SMDK2443
 
 endif	# CPU_S3C2443
 
+config PM_H1940
+	bool
+	help
+	  Internal node for H1940 and related PM
+
 endmenu	# SAMSUNG S3C24XX SoCs Support
 
 endif	# ARCH_S3C24XX
-- 
2.1.0.rc2

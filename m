From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 13 Aug 2010 14:38:52 +0900
Subject: [PATCH] ARM: SAMSUNG: Fix on build warning about dependency in Kconfig
Message-ID: <1281677932-6148-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes on following build warning.

warning: (PLAT_S5P && (ARCH_S5P6440 || ARCH_S5P6442 || ARCH_S5PC100 ||
	     ARCH_S5PV210 || ARCH_S5PV310) || ARCH_S3C64XX && <choice>)
	     selects PLAT_SAMSUNG which has unmet direct dependencies
	     (ARCH_S3C2410 || ARCH_S3C24A0 || ARCH_S3C64XX)

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
Cc: Ben Dooks <ben-linux@fluff.org>
---
Hi, Russell

This is for 2.6.36-rc1.
How can this go to Linus' tree?

Or is it better after rc1?

Thanks.

Best regards,
Kgene.

 arch/arm/plat-samsung/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index 4529dd6..7c0bde7 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -6,7 +6,7 @@
 
 config PLAT_SAMSUNG
 	bool
-	depends on ARCH_S3C2410 || ARCH_S3C24A0 || ARCH_S3C64XX
+	depends on PLAT_S3C24XX || ARCH_S3C64XX || PLAT_S5P
 	select NO_IOPORT
 	default y
 	help
-- 
1.6.2.5

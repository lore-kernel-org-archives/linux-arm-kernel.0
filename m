From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat,  2 Mar 2013 13:22:52 +0400
Subject: [PATCH 2/4] ARM: s3c24xx: Removed unneeded dependency on CPU_S3C2410
In-Reply-To: <1362216174-10478-1-git-send-email-shc_work@mail.ru>
References: <1362216174-10478-1-git-send-email-shc_work@mail.ru>
Message-ID: <1362216174-10478-2-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

S3C2410 boards are already under "if CPU_S3C2410" condition, so
additional dependencies on this symbol can be removed.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-s3c24xx/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-s3c24xx/Kconfig b/arch/arm/mach-s3c24xx/Kconfig
index 567d77b..dddb49b 100644
--- a/arch/arm/mach-s3c24xx/Kconfig
+++ b/arch/arm/mach-s3c24xx/Kconfig
@@ -229,7 +229,7 @@ if CPU_S3C2410
 
 config S3C2410_CPUFREQ
 	bool
-	depends on CPU_FREQ_S3C24XX && CPU_S3C2410
+	depends on CPU_FREQ_S3C24XX
 	select S3C2410_CPUFREQ_UTILS
 	help
 	  CPU Frequency scaling support for S3C2410
-- 
1.7.12.4

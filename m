From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat,  2 Mar 2013 13:22:53 +0400
Subject: [PATCH 3/4] ARM: s3c24xx: Removed unneeded dependency on CPU_S3C2412
In-Reply-To: <1362216174-10478-1-git-send-email-shc_work@mail.ru>
References: <1362216174-10478-1-git-send-email-shc_work@mail.ru>
Message-ID: <1362216174-10478-3-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

S3C2412 boards are already under "if CPU_S3C2412" condition, so
additional dependencies on this symbol can be removed.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-s3c24xx/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/Kconfig b/arch/arm/mach-s3c24xx/Kconfig
index dddb49b..e6f7d7c 100644
--- a/arch/arm/mach-s3c24xx/Kconfig
+++ b/arch/arm/mach-s3c24xx/Kconfig
@@ -377,12 +377,12 @@ if CPU_S3C2412
 config CPU_S3C2412_ONLY
 	bool
 	depends on !CPU_S3C2410 && !CPU_S3C2416 && !CPU_S3C2440 && \
-		   !CPU_S3C2442 && !CPU_S3C2443 && CPU_S3C2412
+		   !CPU_S3C2442 && !CPU_S3C2443
 	default y
 
 config S3C2412_CPUFREQ
 	bool
-	depends on CPU_FREQ_S3C24XX && CPU_S3C2412
+	depends on CPU_FREQ_S3C24XX
 	default y
 	select S3C2412_IOTIMING
 	help
-- 
1.7.12.4

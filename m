From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 31 Aug 2011 11:33:25 +0100
Subject: [PATCH 2/2] ARM: SAMSUNG: Fix mask for S3C64xx CPU IDs
In-Reply-To: <1314786805-15684-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1314786805-15684-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <1314786805-15684-2-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The difference in CPU ID between S3C6400 and S3C6410 is a single bit and
that bit wasn't included in the mask causing the S3C6410 to be misdetected
as a S3C6400.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/plat-samsung/include/plat/cpu.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-samsung/include/plat/cpu.h b/arch/arm/plat-samsung/include/plat/cpu.h
index aa1f69b..4d36130 100644
--- a/arch/arm/plat-samsung/include/plat/cpu.h
+++ b/arch/arm/plat-samsung/include/plat/cpu.h
@@ -26,7 +26,7 @@ extern unsigned long samsung_cpu_id;
 #define S3C6400_CPU_ID		0x36400000
 #define S3C6410_CPU_ID		0x36410000
 #define S3C64XX_CPU_ID		(S3C6400_CPU_ID & S3C6410_CPU_ID)
-#define S3C64XX_CPU_MASK	0x1FF40000
+#define S3C64XX_CPU_MASK	0x1FFF0000
 
 #define S5P6440_CPU_ID		0x56440000
 #define S5P6450_CPU_ID		0x36450000
-- 
1.7.5.4

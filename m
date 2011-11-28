From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 28 Nov 2011 17:26:57 +0000
Subject: [PATCH] ARM: S3C64XX: Staticise s3c6400_sysclass
Message-ID: <1322501217-16770-1-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The symbol is not exported and doesn't need to be.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-s3c64xx/s3c6400.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/s3c6400.c b/arch/arm/mach-s3c64xx/s3c6400.c
index 7a3bc32..51c00f2 100644
--- a/arch/arm/mach-s3c64xx/s3c6400.c
+++ b/arch/arm/mach-s3c64xx/s3c6400.c
@@ -70,7 +70,7 @@ void __init s3c6400_init_irq(void)
 	s3c64xx_init_irq(~0 & ~(0xf << 5), ~0);
 }
 
-struct sysdev_class s3c6400_sysclass = {
+static struct sysdev_class s3c6400_sysclass = {
 	.name	= "s3c6400-core",
 };
 
-- 
1.7.7.3

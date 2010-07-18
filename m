From: sbkim73@samsung.com (Sangbeom Kim)
Date: Mon, 19 Jul 2010 08:31:51 +0900
Subject: [PATCH 2/2] ARM: S3C2416: Change S3C2416 NAND platform device name
In-Reply-To: <1279495911-17346-1-git-send-email-sbkim73@samsung.com>
References: <1279495911-17346-1-git-send-email-sbkim73@samsung.com>
Message-ID: <1279495911-17346-3-git-send-email-sbkim73@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Atul Dahiya <atul.dahiya@samsung.com>

This patch changes the platform device name from 's3c2416-nand' to
's3c2412-nand' so that S3C2416 can reuse the nand functionality
available on S3C2412.

Signed-off-by: Atul Dahiya <atul.dahiya@samsung.com>
Signed-off-by: Sangbeom Kim <sbkim73@samsung.com>
---
 arch/arm/mach-s3c2416/s3c2416.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-s3c2416/s3c2416.c b/arch/arm/mach-s3c2416/s3c2416.c
index bfe674f..6468b6c 100644
--- a/arch/arm/mach-s3c2416/s3c2416.c
+++ b/arch/arm/mach-s3c2416/s3c2416.c
@@ -100,7 +100,7 @@ void __init s3c2416_init_uarts(struct s3c2410_uartcfg *cfg, int no)
 {
 	s3c24xx_init_uartdevs("s3c2440-uart", s3c2410_uart_resources, cfg, no);
 
-	s3c_nand_setname("s3c2416-nand");
+	s3c_nand_setname("s3c2412-nand");
 }
 
 /* s3c2416_map_io
-- 
1.6.2.5

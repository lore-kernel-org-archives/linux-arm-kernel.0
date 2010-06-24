From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 24 Jun 2010 15:49:25 +0200
Subject: [PATCH 29/61] MTD: mxc_nand: make bit fields unsigned to please sparse
In-Reply-To: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1277387397-3467-30-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes:

	arch/arm/plat-mxc/include/mach/mxc_nand.h:25:14: error: dubious one-bit signed bitfield
	arch/arm/plat-mxc/include/mach/mxc_nand.h:26:17: error: dubious one-bit signed bitfield

While at it make width unsigned, too.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/plat-mxc/include/mach/mxc_nand.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/mxc_nand.h b/arch/arm/plat-mxc/include/mach/mxc_nand.h
index 5d2d21d..28988c7 100644
--- a/arch/arm/plat-mxc/include/mach/mxc_nand.h
+++ b/arch/arm/plat-mxc/include/mach/mxc_nand.h
@@ -21,8 +21,8 @@
 #define __ASM_ARCH_NAND_H
 
 struct mxc_nand_platform_data {
-	int width;	/* data bus width in bytes */
-	int hw_ecc:1;	/* 0 if supress hardware ECC */
-	int flash_bbt:1; /* set to 1 to use a flash based bbt */
+	unsigned int width;	/* data bus width in bytes */
+	unsigned int hw_ecc:1;	/* 0 if supress hardware ECC */
+	unsigned int flash_bbt:1; /* set to 1 to use a flash based bbt */
 };
 #endif /* __ASM_ARCH_NAND_H */
-- 
1.7.1

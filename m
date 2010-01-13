From: ramaxlo@gmail.com (Ramax Lo)
Date: Thu, 14 Jan 2010 01:31:24 +0800
Subject: [PATCH] S3C: NAND: Check the existence of nr_map before copying
In-Reply-To: <>
References: <>
Message-ID: <1263403884-8495-1-git-send-email-ramaxlo@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need to check whether the chip number map is provided to avoid unexpected
NULL pointer exception.

Signed-off-by: Ramax Lo <ramaxlo@gmail.com>
---
 arch/arm/plat-s3c/dev-nand.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-s3c/dev-nand.c b/arch/arm/plat-s3c/dev-nand.c
index 84808cc..34697de 100644
--- a/arch/arm/plat-s3c/dev-nand.c
+++ b/arch/arm/plat-s3c/dev-nand.c
@@ -58,8 +58,8 @@ static int __init s3c_nand_copy_set(struct s3c2410_nand_set *set)
 			return -ENOMEM;
 	}
 	
-	size = sizeof(int) * set->nr_chips;
-	if (size) {
+	if (set->nr_map) {
+		size = sizeof(int) * set->nr_chips;
 		ptr = kmemdup(set->nr_map, size, GFP_KERNEL);
 		set->nr_map = ptr;
 
-- 
1.5.4.3

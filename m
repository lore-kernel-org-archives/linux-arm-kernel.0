From: andrea.adami@gmail.com (Andrea Adami)
Date: Tue,  3 Jun 2014 23:29:01 +0200
Subject: [PATCH 2/2] arm: sa1100: collie: add top boot mtd partition
In-Reply-To: <1401830941-17086-1-git-send-email-andrea.adami@gmail.com>
References: <1401830941-17086-1-git-send-email-andrea.adami@gmail.com>
Message-ID: <1401830941-17086-3-git-send-email-andrea.adami@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CFI mapping is now perfect so we can expose the top block, read only.
There isn't much to read, though, just the sharpsl_params values.

Signed-off-by: Andrea Adami <andrea.adami@gmail.com>
---
 arch/arm/mach-sa1100/collie.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-sa1100/collie.c b/arch/arm/mach-sa1100/collie.c
index f26aeea..3f449b0 100644
--- a/arch/arm/mach-sa1100/collie.c
+++ b/arch/arm/mach-sa1100/collie.c
@@ -329,6 +329,11 @@ static struct mtd_partition collie_partitions[] = {
 		.name		= "rootfs",
 		.offset 	= MTDPART_OFS_APPEND,
 		.size		= 0x00e20000,
+	}, {
+		.name		= "bootblock",
+		.offset		= MTDPART_OFS_APPEND,
+		.size		= 0x00020000,
+		.mask_flags	= MTD_WRITEABLE
 	}
 };
 
-- 
1.9.1

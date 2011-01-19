From: matejken@gmail.com (Matej Kenda)
Date: Wed, 19 Jan 2011 13:01:31 +0100
Subject: [PATCH 1/2] Updated XCEP partition sizes
Message-ID: <AANLkTi=42n+h+0buU_83R-y4XkXqy8bkWSquwuLAY56m@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Increased partition for Linux kernel from 1 MB to 2 MB for
monolithically built kernel 2.6.37 for Iskratel XCEP SBC to fit in.

Signed-off-by: Matej Kenda <matejken@gmail.com>

---

diff --git a/arch/arm/mach-pxa/xcep.c b/arch/arm/mach-pxa/xcep.c
index 3260ce7..f7b1052 100644
--- a/arch/arm/mach-pxa/xcep.c
+++ b/arch/arm/mach-pxa/xcep.c
@@ -55,20 +55,20 @@ static struct mtd_partition xcep_partitions[] = {
 	}, {
 		.name =		"Bootloader ENV",
 		.size =		0x00040000,
-		.offset =	0x00040000,
+		.offset =	MTDPART_OFS_APPEND,
 		.mask_flags =	MTD_WRITEABLE
 	}, {
 		.name =		"Kernel",
-		.size =		0x00100000,
-		.offset =	0x00080000,
+		.size =		0x00200000,
+		.offset =	MTDPART_OFS_APPEND,
 	}, {
 		.name =		"Rescue fs",
 		.size =		0x00280000,
-		.offset =	0x00180000,
+		.offset =	MTDPART_OFS_APPEND,
 	}, {
 		.name =		"Filesystem",
 		.size =		MTDPART_SIZ_FULL,
-		.offset =	0x00400000
+		.offset =	MTDPART_OFS_APPEND
 	}
 };

From: john@jjdev.com (John de la Garza)
Date: Sun, 16 Feb 2014 20:38:37 -0800
Subject: [PATCH] arm: removed compiler warning
Message-ID: <20140217043834.GA7563@vega.jjdev.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Removed this compiler warning for arch/arm/boot/compressed/atags_to_fdt.c.
The warning was: 'memsize' may be used uninitialized in this function.

Signed-off-by: John de la Garza <john@jjdev.com>
---
 arch/arm/boot/compressed/atags_to_fdt.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/compressed/atags_to_fdt.c b/arch/arm/boot/compressed/atags_to_fdt.c
index d1153c8..75b64da 100644
--- a/arch/arm/boot/compressed/atags_to_fdt.c
+++ b/arch/arm/boot/compressed/atags_to_fdt.c
@@ -110,7 +110,8 @@ int atags_to_fdt(void *atag_list, void *fdt, int total_space)
 	 * address and size for each bank */
 	uint32_t mem_reg_property[2 * 2 * NR_BANKS];
 	int memcount = 0;
-	int ret, memsize;
+	int memsize = 0;
+	int ret;
 
 	/* make sure we've got an aligned pointer */
 	if ((u32)atag_list & 0x3)
-- 
1.7.10.4

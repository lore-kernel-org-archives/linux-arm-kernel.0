From: rmk@arm.linux.org.uk (Russell King)
Date: Mon, 06 Jun 2016 18:00:26 +0100
Subject: [PATCH kexec-tools v2 20/32] arm: add maximum number of memory ranges
In-Reply-To: <20160606164129.GM1041@n2100.armlinux.org.uk>
References: <20160606164129.GM1041@n2100.armlinux.org.uk>
Message-ID: <E1b9xt4-0003tM-GR@e0050434b2927.dyn.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the maximum number of memory ranges to the list of usable memory
ranges, so that we don't have to carry this around.

Reviewed-by: Pratyush Anand <panand@redhat.com>
Signed-off-by: Russell King <rmk@arm.linux.org.uk>
---
 kexec/arch/arm/crashdump-arm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kexec/arch/arm/crashdump-arm.c b/kexec/arch/arm/crashdump-arm.c
index 739c906..195b43f 100644
--- a/kexec/arch/arm/crashdump-arm.c
+++ b/kexec/arch/arm/crashdump-arm.c
@@ -46,8 +46,8 @@
  */
 static struct memory_range crash_memory_ranges[CRASH_MAX_MEMORY_RANGES];
 struct memory_ranges usablemem_rgns = {
-    .size = 0,
-    .ranges = crash_memory_ranges,
+	.max_size = CRASH_MAX_MEMORY_RANGES,
+	.ranges = crash_memory_ranges,
 };
 
 /* memory range reserved for crashkernel */
-- 
1.9.1

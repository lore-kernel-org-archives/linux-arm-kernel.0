From: rmk@arm.linux.org.uk (Russell King)
Date: Tue, 03 May 2016 11:22:47 +0100
Subject: [PATCH kexec-tools 20/32] arm: add maximum number of memory ranges
In-Reply-To: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
References: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
Message-ID: <E1axXTb-0004it-43@e0050434b2927.dyn.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the maximum number of memory ranges to the list of usable memory
ranges, so that we don't have to carry this around.

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

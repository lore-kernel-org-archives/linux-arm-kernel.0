From: rmk@arm.linux.org.uk (Russell King)
Date: Tue, 03 May 2016 11:22:41 +0100
Subject: [PATCH kexec-tools 19/32] arm: add memory ranges debug
In-Reply-To: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
References: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
Message-ID: <E1axXTV-0004in-Sw@e0050434b2927.dyn.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the call to dbgprint_mem_range() into the ARM version of
get_memory_ranges().

Signed-off-by: Russell King <rmk@arm.linux.org.uk>
---
 kexec/arch/arm/kexec-arm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kexec/arch/arm/kexec-arm.c b/kexec/arch/arm/kexec-arm.c
index e47fc00..eeb27b4 100644
--- a/kexec/arch/arm/kexec-arm.c
+++ b/kexec/arch/arm/kexec-arm.c
@@ -70,6 +70,9 @@ int get_memory_ranges(struct memory_range **range, int *ranges,
 	fclose(fp);
 	*range = memory_range;
 	*ranges = memory_ranges;
+
+	dbgprint_mem_range("MEMORY RANGES", *range, *ranges);
+
 	return 0;
 }
 
-- 
1.9.1

From: rmk@arm.linux.org.uk (Russell King)
Date: Mon, 06 Jun 2016 18:00:21 +0100
Subject: [PATCH kexec-tools v2 19/32] arm: add memory ranges debug
In-Reply-To: <20160606164129.GM1041@n2100.armlinux.org.uk>
References: <20160606164129.GM1041@n2100.armlinux.org.uk>
Message-ID: <E1b9xsz-0003tG-AG@e0050434b2927.dyn.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the call to dbgprint_mem_range() into the ARM version of
get_memory_ranges().

Reviewed-by: Pratyush Anand <panand@redhat.com>
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

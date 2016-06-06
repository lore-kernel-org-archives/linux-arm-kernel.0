From: rmk@arm.linux.org.uk (Russell King)
Date: Mon, 06 Jun 2016 18:01:13 +0100
Subject: [PATCH kexec-tools v2 29/32] arm: add debug of reserved and coredump
 memory ranges
In-Reply-To: <20160606164129.GM1041@n2100.armlinux.org.uk>
References: <20160606164129.GM1041@n2100.armlinux.org.uk>
Message-ID: <E1b9xtp-0003uE-KF@e0050434b2927.dyn.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add debug of the reserved and coredump memory ranges for validation.

Reviewed-by: Pratyush Anand <panand@redhat.com>
Signed-off-by: Russell King <rmk@arm.linux.org.uk>
---
 kexec/arch/arm/crashdump-arm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kexec/arch/arm/crashdump-arm.c b/kexec/arch/arm/crashdump-arm.c
index 25fdbe9..2dc8846 100644
--- a/kexec/arch/arm/crashdump-arm.c
+++ b/kexec/arch/arm/crashdump-arm.c
@@ -158,6 +158,10 @@ static int crash_get_memory_ranges(void)
 		return -1;
 	}
 
+	dbgprint_mem_range("Reserved memory ranges",
+			   crash_reserved_rgns.ranges,
+			   crash_reserved_rgns.size);
+
 	/*
 	 * Exclude all reserved memory from the usable memory regions.
 	 * We want to avoid dumping the crashkernel region itself.  Note
@@ -179,6 +183,9 @@ static int crash_get_memory_ranges(void)
 	 */
 	mem_regions_sort(&usablemem_rgns);
 
+	dbgprint_mem_range("Coredump memory ranges",
+			   usablemem_rgns.ranges, usablemem_rgns.size);
+
 	return 0;
 }
 
-- 
1.9.1

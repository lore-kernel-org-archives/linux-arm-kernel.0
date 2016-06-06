From: rmk@arm.linux.org.uk (Russell King)
Date: Mon, 06 Jun 2016 17:59:55 +0100
Subject: [PATCH kexec-tools v2 14/32] arm: fix off-by-one on memory end
In-Reply-To: <20160606164129.GM1041@n2100.armlinux.org.uk>
References: <20160606164129.GM1041@n2100.armlinux.org.uk>
Message-ID: <E1b9xsZ-0003sm-AQ@e0050434b2927.dyn.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The memory range end is inclusive, not exclusive (see x86).  We should
not be adding one to the value parsed from the /proc/iomem resources.

Reviewed-by: Pratyush Anand <panand@redhat.com>
Signed-off-by: Russell King <rmk@arm.linux.org.uk>
---
 kexec/arch/arm/kexec-arm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kexec/arch/arm/kexec-arm.c b/kexec/arch/arm/kexec-arm.c
index 4e90e69..e47fc00 100644
--- a/kexec/arch/arm/kexec-arm.c
+++ b/kexec/arch/arm/kexec-arm.c
@@ -51,7 +51,6 @@ int get_memory_ranges(struct memory_range **range, int *ranges,
 		if (count != 2)
 			continue;
 		str = line + consumed;
-		end = end + 1;
 
 		if (memcmp(str, "System RAM\n", 11) == 0) {
 			type = RANGE_RAM;
-- 
1.9.1

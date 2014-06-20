From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 20 Jun 2014 11:26:34 +0100
Subject: [PATCH] ARM: arm925: ensure assembly sets up writethrough mapping
In-Reply-To: <20140620085759.GG558@drone.musicnaut.iki.fi>
References: <20140620085759.GG558@drone.musicnaut.iki.fi>
Message-ID: <E1Wxw1i-0004OA-GW@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit ca8f0b0a545f ("ARM: ensure C page table setup code follows
assembly code") did what it said on the tin, but some of the older
CPU code omitted the default cache policy from their files.  This
results in the kernel running with the caches disabled.  Fix this
for ARM925.

Reported-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/proc-arm925.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mm/proc-arm925.S b/arch/arm/mm/proc-arm925.S
index 97448c3acf38..ba0d58e1a2a2 100644
--- a/arch/arm/mm/proc-arm925.S
+++ b/arch/arm/mm/proc-arm925.S
@@ -502,6 +502,7 @@ __\name\()_proc_info:
 	.long	\cpu_val
 	.long	\cpu_mask
 	.long   PMD_TYPE_SECT | \
+		PMD_SECT_CACHEABLE | \
 		PMD_BIT4 | \
 		PMD_SECT_AP_WRITE | \
 		PMD_SECT_AP_READ
-- 
1.8.3.1

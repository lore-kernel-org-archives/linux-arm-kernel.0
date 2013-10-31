From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Thu, 31 Oct 2013 10:37:09 -0700
Subject: [PATCH] arm: zynq: platsmp: Remove CPU presence check
In-Reply-To: <20131031161739.GE16735@n2100.arm.linux.org.uk>
References: <20131031161739.GE16735@n2100.arm.linux.org.uk>
Message-ID: <1383241029-32018-1-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The generic code already checks that the CPU being requested is legal if
the cpu possible/present masks are set correctly.

Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
As per Russel's suggestion, consider this alternative for 1/6.

	S?ren

 arch/arm/mach-zynq/platsmp.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/mach-zynq/platsmp.c b/arch/arm/mach-zynq/platsmp.c
index bc730eb38f00..8021499e7b70 100644
--- a/arch/arm/mach-zynq/platsmp.c
+++ b/arch/arm/mach-zynq/platsmp.c
@@ -39,11 +39,6 @@ int zynq_cpun_start(u32 address, int cpu)
 	u32 trampoline_code_size = &zynq_secondary_trampoline_end -
 						&zynq_secondary_trampoline;
 
-	if (cpu > ncores) {
-		pr_warn("CPU No. is not available in the system\n");
-		return -1;
-	}
-
 	/* MS: Expectation that SLCR are directly map and accessible */
 	/* Not possible to jump to non aligned address */
 	if (!(address & 3) && (!address || (address >= trampoline_code_size))) {
-- 
1.8.4.1

From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 15 Oct 2009 13:21:58 +0100
Subject: [PATCH 2/4] RealView: Remove duplicated #define REALVIEW_SYS_FLAGS*
	statements
In-Reply-To: <20091015121927.739.32071.stgit@pc1117.cambridge.arm.com>
References: <20091015121927.739.32071.stgit@pc1117.cambridge.arm.com>
Message-ID: <20091015122158.739.70419.stgit@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin Tuckley <colin.tuckley@arm.com>

The platsmp.c file defines the REALVIEW_SYS_FLAGS* macros which are
already present in platform.h. Just use the latter.

Signed-off-by: Colin Tuckley <colin.tuckley@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/mach-realview/platsmp.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-realview/platsmp.c b/arch/arm/mach-realview/platsmp.c
index a88458b..0092658 100644
--- a/arch/arm/mach-realview/platsmp.c
+++ b/arch/arm/mach-realview/platsmp.c
@@ -146,11 +146,8 @@ static void __init poke_milo(void)
 	 * register. The BootMonitor waits for this register to become
 	 * non-zero.
 	 */
-#define REALVIEW_SYS_FLAGSS_OFFSET 0x30
-#define REALVIEW_SYS_FLAGSC_OFFSET 0x34
 	__raw_writel(BSYM(virt_to_phys(realview_secondary_startup)),
-		     __io_address(REALVIEW_SYS_BASE) +
-		     REALVIEW_SYS_FLAGSS_OFFSET);
+		     __io_address(REALVIEW_SYS_FLAGSSET));
 
 	mb();
 }

From: andrew.ruder@elecsyscorp.com (Andrew Ruder)
Date: Thu,  5 Jun 2014 14:10:56 -0500
Subject: [PATCH] arm: pxa: correct errata number for PXA270
Message-ID: <1401995457-24721-1-git-send-email-andrew.ruder@elecsyscorp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Comment incorrectly cites errata 39
    E39. SDIO: SDIO Devices Not Working at 19.5 Mbps

Should be errata 38
    E38. MEMC: Memory Controller hangs when entering Self Refresh Mode.

Signed-off-by: Andrew Ruder <andrew.ruder@elecsyscorp.com>
---
 arch/arm/mach-pxa/sleep.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-pxa/sleep.S b/arch/arm/mach-pxa/sleep.S
index 1e544be..6c5b3ff 100644
--- a/arch/arm/mach-pxa/sleep.S
+++ b/arch/arm/mach-pxa/sleep.S
@@ -157,7 +157,7 @@ pxa_cpu_do_suspend:
 	@ Do not reorder...
 	@ Intel PXA270 Specification Update notes problems performing
 	@ external accesses after SDRAM is put in self-refresh mode
-	@ (see Errata 39 ...hangs when entering self-refresh mode)
+	@ (see Errata 38 ...hangs when entering self-refresh mode)
 
 	@ force address lines low by reading at physical address 0
 	ldr	r3, [r2]
-- 
1.9.0.rc3.12.gbc97e2d

From: abhijitpagare@ti.com (Abhijit Pagare)
Date: Fri,  8 Jan 2010 17:29:04 +0530
Subject: [PATCH] ARM: OMAP4: Power Domains: Remove the return as power domain
	framework is in place
Message-ID: <1262951944-7693-1-git-send-email-abhijitpagare@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The return prevents the power domains from getting registered.
Hence removing it to allow the frameworks model to work.

Signed-off-by: Abhijit Pagare <abhijitpagare@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---

Compiled and Boot Tested on OMAP4430 simulator and ES1 Chip
Compiled and Boot Tested on OMAP3430 SDP
Compiled for OMAP2430 and OMAP2420

 arch/arm/mach-omap2/id.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index a779240..6d1e97b 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -362,7 +362,6 @@ void __init omap2_check_revision(void)
 		omap3_cpuinfo();
 	} else if (cpu_is_omap44xx()) {
 		omap4_check_revision();
-		return;
 	} else {
 		pr_err("OMAP revision unknown, please fix!\n");
 	}
-- 
1.5.4.7

From: Baohua.Song@csr.com (Barry Song)
Date: Tue, 23 Aug 2011 18:31:26 -0700
Subject: [PATCH 2/2] ARM: mach-ux500: add explicit cpu_relax() for busy wait
	loop
Message-ID: <1314149486-5105-1-git-send-email-Baohua.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

using cpu_relax in busy loops is a well-known idiom in the kernel. It's more
for documentation purposes than technically needed here.

Cc: Jamie Iles <jamie@jamieiles.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/mach-ux500/cpu.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-ux500/cpu.c b/arch/arm/mach-ux500/cpu.c
index 1da23bb..76ee355 100644
--- a/arch/arm/mach-ux500/cpu.c
+++ b/arch/arm/mach-ux500/cpu.c
@@ -62,7 +62,7 @@ static inline void ux500_cache_wait(void __iomem *reg, unsigned long mask)
 {
 	/* wait for the operation to complete */
 	while (readl_relaxed(reg) & mask)
-		;
+		cpu_relax();
 }
 
 static inline void ux500_cache_sync(void)
-- 
1.7.1



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog

From: marek.vasut@gmail.com (Marek Vasut)
Date: Mon, 10 Jan 2011 00:29:02 +0100
Subject: [PATCH 1/5] pxa: Fix warning in zeus.c
Message-ID: <1294615746-27668-1-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
 arch/arm/mach-pxa/zeus.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-pxa/zeus.c b/arch/arm/mach-pxa/zeus.c
index c87f2b3..29830a3 100644
--- a/arch/arm/mach-pxa/zeus.c
+++ b/arch/arm/mach-pxa/zeus.c
@@ -830,8 +830,8 @@ static void __init zeus_init(void)
 	pr_info("Zeus CPLD V%dI%d\n", (system_rev & 0xf0) >> 4, (system_rev & 0x0f));
 
 	/* Fix timings for dm9000s (CS1/CS2)*/
-	msc0 = __raw_readl(MSC0) & 0x0000ffff | (dm9000_msc << 16);
-	msc1 = __raw_readl(MSC1) & 0xffff0000 | dm9000_msc;
+	msc0 = (__raw_readl(MSC0) & 0x0000ffff) | (dm9000_msc << 16);
+	msc1 = (__raw_readl(MSC1) & 0xffff0000) | dm9000_msc;
 	__raw_writel(msc0, MSC0);
 	__raw_writel(msc1, MSC1);
 
-- 
1.7.2.3

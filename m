From: alex@digriz.org.uk (Alexander Clouter)
Date: Sat, 14 Apr 2012 19:00:53 +0100
Subject: [PATCH 2/3] ARM: orion5x: ts78xx fix NAND resource off by one
In-Reply-To: <1334426454-3206-1-git-send-email-alex@digriz.org.uk>
References: <1334426454-3206-1-git-send-email-alex@digriz.org.uk>
Message-ID: <1334426454-3206-3-git-send-email-alex@digriz.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Alexander Clouter <alex@digriz.org.uk>
---
 arch/arm/mach-orion5x/ts78xx-setup.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-orion5x/ts78xx-setup.c b/arch/arm/mach-orion5x/ts78xx-setup.c
index c41f27b..4ae822b 100644
--- a/arch/arm/mach-orion5x/ts78xx-setup.c
+++ b/arch/arm/mach-orion5x/ts78xx-setup.c
@@ -294,7 +294,7 @@ static struct platform_nand_data ts78xx_ts_nand_data = {
 
 static struct resource ts78xx_ts_nand_resources = {
 	.start		= TS_NAND_DATA,
-	.end		= TS_NAND_DATA + 4,
+	.end		= TS_NAND_DATA + 4 - 1,
 	.flags		= IORESOURCE_MEM,
 };
 
-- 
1.7.10

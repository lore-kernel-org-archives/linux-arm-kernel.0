From: manjunath.hadli@ti.com (Manjunath Hadli)
Date: Tue, 13 Dec 2011 16:53:31 +0530
Subject: [PATCH v5 07/11] davinci: dm644x: Replace register base value with a
 defined macro
In-Reply-To: <1323775415-24504-1-git-send-email-manjunath.hadli@ti.com>
References: <1323775415-24504-1-git-send-email-manjunath.hadli@ti.com>
Message-ID: <1323775415-24504-8-git-send-email-manjunath.hadli@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace hard coded value of vpss register base to a define macro
DM644X_VPSS_REG_BASE for proper readability

Signed-off-by: Manjunath Hadli <manjunath.hadli@ti.com>
Acked-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/mach-davinci/dm644x.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index 6b1d473..3802b59 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -594,13 +594,15 @@ static struct platform_device dm644x_asp_device = {
 	.resource	= dm644x_asp_resources,
 };
 
+#define DM644X_VPSS_REG_BASE	0x01c73400
+
 static struct resource dm644x_vpss_resources[] = {
 	{
 		/* VPSS Base address */
 		.name		= "vpss",
-		.start          = 0x01c73400,
-		.end            = 0x01c73400 + 0xff,
-		.flags          = IORESOURCE_MEM,
+		.start		= DM644X_VPSS_REG_BASE,
+		.end		= DM644X_VPSS_REG_BASE + 0xff,
+		.flags		= IORESOURCE_MEM,
 	},
 };
 
-- 
1.6.2.4

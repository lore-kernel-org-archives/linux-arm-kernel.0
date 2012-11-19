From: horms@verge.net.au (Simon Horman)
Date: Mon, 19 Nov 2012 10:24:14 +0900
Subject: [PATCH] ARM: shmobile: mackerel: Add FLCTL IRQ resource
In-Reply-To: <1353288254-6211-1-git-send-email-horms@verge.net.au>
References: <1353288254-6211-1-git-send-email-horms@verge.net.au>
Message-ID: <1353288254-6211-2-git-send-email-horms@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bastian Hecht <hechtb@gmail.com>

Since commit 3c7ea4eccfd2e the sh_flctl driver requires the error IRQ line to
signal failed transactions between the flash controller and the NAND chip.
This information is mandatory - else the driver refuses to start up. We
provide it here for the board mackerel.

Signed-off-by: Bastian Hecht <hechtb@gmail.com>
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 arch/arm/mach-shmobile/board-mackerel.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index bf2bcb9..3f56e70 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -950,7 +950,11 @@ static struct resource nand_flash_resources[] = {
 		.start	= 0xe6a30000,
 		.end	= 0xe6a3009b,
 		.flags	= IORESOURCE_MEM,
-	}
+	},
+	[1] = {
+		.start	= evt2irq(0x0d80), /* flstei: status error irq */
+		.flags	= IORESOURCE_IRQ,
+	},
 };
 
 static struct sh_flctl_platform_data nand_flash_data = {
-- 
1.7.10.4

From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 13 Jun 2013 16:00:29 +0900
Subject: [PATCH 05/12] ARM: shmobile: r8a7779: remove USB PHY 2nd memory
 resource
In-Reply-To: <1371106836-25388-1-git-send-email-horms+renesas@verge.net.au>
References: <1371106836-25388-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1371106836-25388-6-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Now that 'drivers/usb/phy/phy-rcar-usb.c' doesn't require the second memory
resource anymore, we can remove it from the R8A7779's USB PHY platform device.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-r8a7779.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c b/arch/arm/mach-shmobile/setup-r8a7779.c
index a3d0e55..a6406cd 100644
--- a/arch/arm/mach-shmobile/setup-r8a7779.c
+++ b/arch/arm/mach-shmobile/setup-r8a7779.c
@@ -395,11 +395,6 @@ static struct resource usb_phy_resources[] = {
 		.end		= 0xffe70900 - 1,
 		.flags		= IORESOURCE_MEM,
 	},
-	[1] = {
-		.start		= 0xfff70000,
-		.end		= 0xfff70900 - 1,
-		.flags		= IORESOURCE_MEM,
-	},
 };
 
 static struct platform_device usb_phy_device = {
-- 
1.8.2.1

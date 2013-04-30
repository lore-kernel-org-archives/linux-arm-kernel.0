From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 1 May 2013 02:56:05 +0400
Subject: [PATCH v7 5/9] ARM: shmobile: r8a7779: remove USB PHY 2nd memory
 resource
In-Reply-To: <201305010242.37483.sergei.shtylyov@cogentembedded.com>
References: <201305010242.37483.sergei.shtylyov@cogentembedded.com>
Message-ID: <201305010256.06379.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that 'drivers/usb/phy/rcar-phy.c' doesn't require the second memory resource
anymore, we can remove it from the R8A7779's USB PHY platform device.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Simon Horman <horms+renesas@verge.net.au>

---
Changes since version 4:
- refreshed the patch.

Changes since version 3:
- lowercased the SoC name in the subject.

Changes since version 2:
- refreshed atop of the prior patches;
- added a note about testing to the changelog;
- added ACKs from Simon Horman and Kuninori Morimoto.

Changes since the original posting:
- new patch in this version, split from the previous one.

 arch/arm/mach-shmobile/setup-r8a7779.c |    5 -----
 1 file changed, 5 deletions(-)

Index: renesas/arch/arm/mach-shmobile/setup-r8a7779.c
===================================================================
--- renesas.orig/arch/arm/mach-shmobile/setup-r8a7779.c
+++ renesas/arch/arm/mach-shmobile/setup-r8a7779.c
@@ -395,11 +395,6 @@ static struct resource usb_phy_resources
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

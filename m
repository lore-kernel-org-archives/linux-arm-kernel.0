From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 9 Apr 2013 01:26:27 +0400
Subject: [PATCH v2 5/9] ARM: shmobile: R8A7779: remove USB PHY 2nd memory
 resource
Message-ID: <201304090126.27827.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that 'drivers/usb/phy/rcar-phy.c' doesn't require the second memory resource
anymore, we can remove it from the R8A7779's USB PHY platform device.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
Changes since the original posting:
- new patch in this version, split from the previous one.

 arch/arm/mach-shmobile/setup-r8a7779.c |    5 -----
 1 file changed, 5 deletions(-)

Index: renesas/arch/arm/mach-shmobile/setup-r8a7779.c
===================================================================
--- renesas.orig/arch/arm/mach-shmobile/setup-r8a7779.c
+++ renesas/arch/arm/mach-shmobile/setup-r8a7779.c
@@ -405,11 +405,6 @@ static struct resource usb_phy_resources
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

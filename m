From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 8 Mar 2013 02:31:03 +0300
Subject: [PATCH] ARM: shmobile: R8A7779: use gic_iid() in SATA IRQ resource
Message-ID: <201303080231.04149.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit "ARM: shmobile: r8a7779: use gic_iid macro" switched R8A7779 platform
devices to using gic_iid() macro instead of gic_spi() but commit "ARM: mach-
shmobile: r8a7779: add SATA support" added another use of gic_spi(). Convert
the SATA IRQ resource to using gic_iid().

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
This patch is atop of the 'next' branch of Simon Horman's renesas.git.

 arch/arm/mach-shmobile/setup-r8a7779.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: renesas/arch/arm/mach-shmobile/setup-r8a7779.c
===================================================================
--- renesas.orig/arch/arm/mach-shmobile/setup-r8a7779.c
+++ renesas/arch/arm/mach-shmobile/setup-r8a7779.c
@@ -331,7 +331,7 @@ static struct resource sata_resources[] 
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= gic_spi(100),
+		.start	= gic_iid(0x84),
 		.flags	= IORESOURCE_IRQ,
 	},
 };

From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 20:59:39 +0900
Subject: [PATCH 12/13] ARM: shmobile: marzen: Use gic_iid macro for ICCIAR /
 interrupt ID
In-Reply-To: <1363607980-22153-1-git-send-email-horms+renesas@verge.net.au>
References: <1363607980-22153-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363607980-22153-13-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

ARM: shmobile: add gic_iid macro for ICCIAR / interrupt ID
enabled to use gic_iid macro.
This patch exchange current GIC interrupt setting
from gic_spi() to gic_iid()

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
[ horms+renesas at verge.net.au: Split irq.h portion into a separate patch ]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-marzen.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-marzen.c b/arch/arm/mach-shmobile/board-marzen.c
index 5852331..2333a2d 100644
--- a/arch/arm/mach-shmobile/board-marzen.c
+++ b/arch/arm/mach-shmobile/board-marzen.c
@@ -67,7 +67,7 @@ static struct resource smsc911x_resources[] = {
 		.flags		= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start		= gic_spi(28), /* IRQ 1 */
+		.start		= gic_iid(0x3c), /* IRQ 1 */
 		.flags		= IORESOURCE_IRQ,
 	},
 };
@@ -97,7 +97,7 @@ static struct resource sdhi0_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= gic_spi(104),
+		.start	= gic_iid(0x88),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -215,7 +215,7 @@ static struct resource ehci0_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= gic_spi(44),
+		.start	= gic_iid(0x4c),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -239,7 +239,7 @@ static struct resource ehci1_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= gic_spi(45),
+		.start	= gic_iid(0x4d),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -269,7 +269,7 @@ static struct resource ohci0_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= gic_spi(44),
+		.start	= gic_iid(0x4c),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -293,7 +293,7 @@ static struct resource ohci1_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= gic_spi(45),
+		.start	= gic_iid(0x4d),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
-- 
1.7.10.4

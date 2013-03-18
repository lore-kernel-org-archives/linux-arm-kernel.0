From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 21:32:52 +0900
Subject: [PATCH 42/43] ARM: shmobile: R8A7779: use gic_iid() in SATA IRQ
 resource
In-Reply-To: <1363609973-31086-1-git-send-email-horms+renesas@verge.net.au>
References: <1363609973-31086-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363609973-31086-43-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Commit "ARM: shmobile: r8a7779: use gic_iid macro" switched R8A7779 platform
devices to using gic_iid() macro instead of gic_spi() but commit "ARM: mach-
shmobile: r8a7779: add SATA support" added another use of gic_spi(). Convert
the SATA IRQ resource to using gic_iid().

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-r8a7779.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c b/arch/arm/mach-shmobile/setup-r8a7779.c
index 10031fe..042df35 100644
--- a/arch/arm/mach-shmobile/setup-r8a7779.c
+++ b/arch/arm/mach-shmobile/setup-r8a7779.c
@@ -331,7 +331,7 @@ static struct resource sata_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= gic_spi(100),
+		.start	= gic_iid(0x84),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
-- 
1.7.10.4

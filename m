From: horms@verge.net.au (Simon Horman)
Date: Tue, 18 Sep 2012 13:46:59 +0900
Subject: [PATCH] ARM: shmobile: kzm9g: bugfix: correct mmcif interrupt settings
In-Reply-To: <1347943619-27649-1-git-send-email-horms@verge.net.au>
References: <1347943619-27649-1-git-send-email-horms@verge.net.au>
Message-ID: <1347943619-27649-2-git-send-email-horms@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tetsuyuki Kobayashi <koba@kmckk.co.jp>

Correct interrupt settings of sh_mmc:int and sh_mmc:error in board-kzm9g.c.

Signed-off-by: Tetsuyuki Kobayashi <koba@kmckk.co.jp>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 arch/arm/mach-shmobile/board-kzm9g.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-kzm9g.c b/arch/arm/mach-shmobile/board-kzm9g.c
index 53b7ea9..3b8a017 100644
--- a/arch/arm/mach-shmobile/board-kzm9g.c
+++ b/arch/arm/mach-shmobile/board-kzm9g.c
@@ -346,11 +346,11 @@ static struct resource sh_mmcif_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= gic_spi(141),
+		.start	= gic_spi(140),
 		.flags	= IORESOURCE_IRQ,
 	},
 	[2] = {
-		.start	= gic_spi(140),
+		.start	= gic_spi(141),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
-- 
1.7.10.4

From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  8 Oct 2013 18:05:42 +0900
Subject: [PATCH 3/4] ARM: shmobile: r8a7778: r8a7778_register_hspi() become
 static
In-Reply-To: <cover.1381222967.git.horms+renesas@verge.net.au>
References: <cover.1381222967.git.horms+renesas@verge.net.au>
Message-ID: <117378e58365a44b568655e5aa49b3f6daf900c4.1381222967.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

r8a7778_register_hspi() used only from setup-r8a7778.c
it can be static

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-r8a7778.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
index f5e15c9..468ee65 100644
--- a/arch/arm/mach-shmobile/setup-r8a7778.c
+++ b/arch/arm/mach-shmobile/setup-r8a7778.c
@@ -258,7 +258,7 @@ static struct resource hspi_resources[] __initdata = {
 	DEFINE_RES_IRQ(gic_iid(0x75)),
 };
 
-void __init r8a7778_register_hspi(int id)
+static void __init r8a7778_register_hspi(int id)
 {
 	BUG_ON(id < 0 || id > 2);
 
-- 
1.8.4

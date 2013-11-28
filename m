From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 28 Nov 2013 17:54:25 +0900
Subject: [PATCH 01/16] ARM: shmobile: ape6evm: don't use named resource for
 MMCIF
In-Reply-To: <cover.1385628709.git.horms+renesas@verge.net.au>
References: <cover.1385628709.git.horms+renesas@verge.net.au>
Message-ID: <61a4fd12d43426fa52fb05dbf21efa057b4a7e78.1385628709.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

sh_mmcif driver doesn't care resource name.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-ape6evm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-ape6evm.c b/arch/arm/mach-shmobile/board-ape6evm.c
index 0fa068e..94adf61 100644
--- a/arch/arm/mach-shmobile/board-ape6evm.c
+++ b/arch/arm/mach-shmobile/board-ape6evm.c
@@ -168,7 +168,7 @@ static const struct sh_mmcif_plat_data mmcif0_pdata __initconst = {
 };
 
 static const struct resource mmcif0_resources[] __initconst = {
-	DEFINE_RES_MEM_NAMED(0xee200000, 0x100, "MMCIF0"),
+	DEFINE_RES_MEM(0xee200000, 0x100),
 	DEFINE_RES_IRQ(gic_spi(169)),
 };
 
-- 
1.8.4

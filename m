From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 28 Nov 2013 17:54:30 +0900
Subject: [PATCH 06/16] ARM: shmobile: sh73a0: don't use named resource for
 IPMMU
In-Reply-To: <cover.1385628709.git.horms+renesas@verge.net.au>
References: <cover.1385628709.git.horms+renesas@verge.net.au>
Message-ID: <6244cd7341ea234c2850c1b6907d216db2582f64.1385628709.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

shmobile-ipmmu driver doesn't care resource name.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-sh73a0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
index c515801..65151c4 100644
--- a/arch/arm/mach-shmobile/setup-sh73a0.c
+++ b/arch/arm/mach-shmobile/setup-sh73a0.c
@@ -722,7 +722,7 @@ static struct platform_device pmu_device = {
 
 /* an IPMMU module for ICB */
 static struct resource ipmmu_resources[] = {
-	DEFINE_RES_MEM_NAMED(0xfe951000, 0x100, "IPMMU"),
+	DEFINE_RES_MEM(0xfe951000, 0x100),
 };
 
 static const char * const ipmmu_dev_names[] = {
-- 
1.8.4

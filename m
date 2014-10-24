From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 24 Oct 2014 17:33:09 +0900
Subject: [PATCH 2/2] ARM: shmobile: r8a7791: Correct number of CPU cores
In-Reply-To: <1414139589-13605-1-git-send-email-horms+renesas@verge.net.au>
References: <1414139589-13605-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1414139589-13605-3-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>

The r8a7791 only has 2 CPU CA15 cores, not 4 CA15 and 4  CA7 cores.

Signed-off-by: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/smp-r8a7791.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/arm/mach-shmobile/smp-r8a7791.c b/arch/arm/mach-shmobile/smp-r8a7791.c
index 96e392c..7e49e0a 100644
--- a/arch/arm/mach-shmobile/smp-r8a7791.c
+++ b/arch/arm/mach-shmobile/smp-r8a7791.c
@@ -28,11 +28,7 @@
 static struct rcar_apmu_config r8a7791_apmu_config[] = {
 	{
 		.iomem = DEFINE_RES_MEM(0xe6152000, 0x88),
-		.cpus = { 0, 1, 2, 3 },
-	},
-	{
-		.iomem = DEFINE_RES_MEM(0xe6151000, 0x88),
-		.cpus = { 0x100, 0x0101, 0x102, 0x103 },
+		.cpus = { 0, 1 },
 	}
 };
 
-- 
2.1.1

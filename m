From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 26 Feb 2015 15:21:19 +0900
Subject: [PATCH 22/32] ARM: shmobile: r8a7791: smp: remap whole apmu region
In-Reply-To: <cover.1424849129.git.horms+renesas@verge.net.au>
References: <cover.1424849129.git.horms+renesas@verge.net.au>
Message-ID: <98f60f8600694ce05c0cba34acce4d77acaea4f9.1424849129.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Documentation says the last register is at 0x184 (CAxCPUCMCR), so use
proper length. Current APMU code accesses CAxCPUnCR which is currently
outside of the remapped area.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/smp-r8a7791.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/smp-r8a7791.c b/arch/arm/mach-shmobile/smp-r8a7791.c
index 7e49e0a..de1d92d 100644
--- a/arch/arm/mach-shmobile/smp-r8a7791.c
+++ b/arch/arm/mach-shmobile/smp-r8a7791.c
@@ -27,7 +27,7 @@
 
 static struct rcar_apmu_config r8a7791_apmu_config[] = {
 	{
-		.iomem = DEFINE_RES_MEM(0xe6152000, 0x88),
+		.iomem = DEFINE_RES_MEM(0xe6152000, 0x188),
 		.cpus = { 0, 1 },
 	}
 };
-- 
2.1.4

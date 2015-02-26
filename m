From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 26 Feb 2015 15:21:18 +0900
Subject: [PATCH 21/32] ARM: shmobile: r8a7790: smp: remap whole apmu region
In-Reply-To: <cover.1424849129.git.horms+renesas@verge.net.au>
References: <cover.1424849129.git.horms+renesas@verge.net.au>
Message-ID: <1d66f72d2c79b76b7353ea4e42f33521fa839f81.1424849129.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Documentation says the last register is at 0x184 (CAxCPUCMCR), so use
proper length. Current APMU code accesses CAxCPUnCR which is currently
outside of the remapped area.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/smp-r8a7790.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/smp-r8a7790.c b/arch/arm/mach-shmobile/smp-r8a7790.c
index 9c3da13..a5bef87 100644
--- a/arch/arm/mach-shmobile/smp-r8a7790.c
+++ b/arch/arm/mach-shmobile/smp-r8a7790.c
@@ -37,11 +37,11 @@ static struct rcar_sysc_ch r8a7790_ca7_scu = {
 
 static struct rcar_apmu_config r8a7790_apmu_config[] = {
 	{
-		.iomem = DEFINE_RES_MEM(0xe6152000, 0x88),
+		.iomem = DEFINE_RES_MEM(0xe6152000, 0x188),
 		.cpus = { 0, 1, 2, 3 },
 	},
 	{
-		.iomem = DEFINE_RES_MEM(0xe6151000, 0x88),
+		.iomem = DEFINE_RES_MEM(0xe6151000, 0x188),
 		.cpus = { 0x100, 0x0101, 0x102, 0x103 },
 	}
 };
-- 
2.1.4

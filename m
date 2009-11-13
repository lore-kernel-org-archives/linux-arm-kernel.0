From: tony@atomide.com (Tony Lindgren)
Date: Thu, 12 Nov 2009 16:08:35 -0800
Subject: [PATCH 07/14] omap3630: Add HSMMC related checks
In-Reply-To: <20091113000444.9034.41293.stgit@localhost>
References: <20091113000444.9034.41293.stgit@localhost>
Message-ID: <20091113000835.9034.22039.stgit@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Madhu <madhu.cr@ti.com>

Change the cpu_is_omap3430() check to cpu_is_omap34xx() to allow HSMMC1/2
mux configuration for omap3630.

Signed-off-by: Madhusudhan Chikkature <madhu.cr@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/devices.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 7d4513b..8d23e1f 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -575,7 +575,7 @@ static inline void omap2_mmc_mux(struct omap_mmc_platform_data *mmc_controller,
 		}
 	}
 
-	if (cpu_is_omap3430()) {
+	if (cpu_is_omap34xx()) {
 		if (controller_nr == 0) {
 			omap_cfg_reg(N28_3430_MMC1_CLK);
 			omap_cfg_reg(M27_3430_MMC1_CMD);

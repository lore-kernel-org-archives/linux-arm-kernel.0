From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  1 Oct 2013 11:37:17 +0900
Subject: [PATCH 12/12] ARM: shmobile: lager: disable MMCIF Command Completion
 Signal, add CLK_CTRL2
In-Reply-To: <cover.1380530519.git.horms+renesas@verge.net.au>
References: <cover.1380530519.git.horms+renesas@verge.net.au>
Message-ID: <b77c6bcef2082a7cd96124daf15df8da5b670ebe.1380530519.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

MMCIF on r8a7790 doesn't support Command Completion Signal, but it does
implement a CE_CLK_CTRL2 register. Platform parameters have to be added to
account for these features on lager.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-lager.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
index 9fbbf23..1e23142 100644
--- a/arch/arm/mach-shmobile/board-lager.c
+++ b/arch/arm/mach-shmobile/board-lager.c
@@ -142,6 +142,8 @@ static struct regulator_consumer_supply fixed3v3_power_consumers[] =
 /* MMCIF */
 static struct sh_mmcif_plat_data mmcif1_pdata __initdata = {
 	.caps		= MMC_CAP_8_BIT_DATA | MMC_CAP_NONREMOVABLE,
+	.clk_ctrl2_present = true,
+	.ccs_unsupported = true,
 };
 
 static struct resource mmcif1_resources[] __initdata = {
-- 
1.8.4

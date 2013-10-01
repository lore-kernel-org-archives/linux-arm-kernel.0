From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  1 Oct 2013 11:37:09 +0900
Subject: [PATCH 09/12] ARM: shmobile: ape6evm: disable MMCIF Command
 Completion Signal
In-Reply-To: <cover.1380530519.git.horms+renesas@verge.net.au>
References: <cover.1380530519.git.horms+renesas@verge.net.au>
Message-ID: <a2eeabcceb3eb2646b0064b55b8ff0eb6f1ae13d.1380530519.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

MMCIF on r8a73a4 doesn't support Command Completion Signal, a platform
parameter has to be added to disable it on ape6evm.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-ape6evm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-shmobile/board-ape6evm.c b/arch/arm/mach-shmobile/board-ape6evm.c
index 02be420..0365d2e 100644
--- a/arch/arm/mach-shmobile/board-ape6evm.c
+++ b/arch/arm/mach-shmobile/board-ape6evm.c
@@ -162,6 +162,7 @@ static struct regulator_consumer_supply vcc_sdhi1_consumers[] =
 /* MMCIF */
 static const struct sh_mmcif_plat_data mmcif0_pdata __initconst = {
 	.caps		= MMC_CAP_8_BIT_DATA | MMC_CAP_NONREMOVABLE,
+	.ccs_unsupported = true,
 };
 
 static const struct resource mmcif0_resources[] __initconst = {
-- 
1.8.4

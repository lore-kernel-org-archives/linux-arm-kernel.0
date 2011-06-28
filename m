From: silesh@ti.com (Silesh C V)
Date: Tue, 28 Jun 2011 11:26:24 +0530
Subject: [PATCH] OMAP: 4430SDP: Register the card detect GPIO properly
Message-ID: <1309240584-17401-1-git-send-email-silesh@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Without this the HSMMC driver takes GPIO 0 to be the card detect gpio
and requests/configures it. This will give rise to issues when another
driver needs to use GPIO 0. On 4430SDP, the card detection is through
TWL 6030.

Signed-off-by: Silesh C V <silesh@ti.com>
---
 arch/arm/mach-omap2/board-4430sdp.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 63de2d3..7a1460f 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -327,6 +327,7 @@ static struct omap2_hsmmc_info mmc[] = {
 	{
 		.mmc		= 1,
 		.caps		= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA,
+		.gpio_cd	= -EINVAL,
 		.gpio_wp	= -EINVAL,
 	},
 	{}	/* Terminator */
-- 
1.7.1

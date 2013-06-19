From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 19 Jun 2013 22:22:35 +0900
Subject: [PATCH 4/4] sh-pfc: r8a7778: tidyup MMC_D1 pin
In-Reply-To: <1371648155-18479-1-git-send-email-horms+renesas@verge.net.au>
References: <1371648155-18479-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1371648155-18479-5-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

MMC_D1 is RCAR_GP_PIN(1, 8), not RCAR_GP_PIN(2, 8)

Reported-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7778.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7778.c b/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
index 1dcbabc..f903910 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
@@ -1447,11 +1447,11 @@ MMC_PFC_PINS(mmc_ctrl,		RCAR_GP_PIN(1, 5),	RCAR_GP_PIN(1, 6));
 MMC_PFC_CTRL(mmc_ctrl,		MMC_CLK,		MMC_CMD);
 MMC_PFC_PINS(mmc_data1,		RCAR_GP_PIN(1, 7));
 MMC_PFC_DAT1(mmc_data1,		MMC_D0);
-MMC_PFC_PINS(mmc_data4,		RCAR_GP_PIN(1, 7),	RCAR_GP_PIN(2, 8),
+MMC_PFC_PINS(mmc_data4,		RCAR_GP_PIN(1, 7),	RCAR_GP_PIN(1, 8),
 				RCAR_GP_PIN(0, 5),	RCAR_GP_PIN(0, 6));
 MMC_PFC_DAT4(mmc_data4,		MMC_D0,			MMC_D1,
 				MMC_D2,			MMC_D3);
-MMC_PFC_PINS(mmc_data8,		RCAR_GP_PIN(1, 7),	RCAR_GP_PIN(2, 8),
+MMC_PFC_PINS(mmc_data8,		RCAR_GP_PIN(1, 7),	RCAR_GP_PIN(1, 8),
 				RCAR_GP_PIN(0, 5),	RCAR_GP_PIN(0, 6),
 				RCAR_GP_PIN(1, 4),	RCAR_GP_PIN(1, 0),
 				RCAR_GP_PIN(0, 30),	RCAR_GP_PIN(0, 31));
-- 
1.8.2.1

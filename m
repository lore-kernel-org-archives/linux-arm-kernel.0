From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  5 Jun 2013 17:26:08 +0900
Subject: [PATCH 077/130] ARM: shmobile: bonito: Register pinctrl mapping for
 BSC
In-Reply-To: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
References: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1370420821-28420-78-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Replace the GPIO-based BSC pinmux configuration by a pinctrl mapping.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-bonito.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-bonito.c b/arch/arm/mach-shmobile/board-bonito.c
index 5076f4d..2781c7f 100644
--- a/arch/arm/mach-shmobile/board-bonito.c
+++ b/arch/arm/mach-shmobile/board-bonito.c
@@ -377,6 +377,12 @@ static void __init bonito_map_io(void)
 static const struct pinctrl_map fpga_pinctrl_map[] = {
 	/* FPGA */
 	PIN_MAP_MUX_GROUP_DEFAULT("pfc-r8a7740", "pfc-r8a7740",
+				  "bsc_cs5a_0", "bsc"),
+	PIN_MAP_MUX_GROUP_DEFAULT("pfc-r8a7740", "pfc-r8a7740",
+				  "bsc_cs5b", "bsc"),
+	PIN_MAP_MUX_GROUP_DEFAULT("pfc-r8a7740", "pfc-r8a7740",
+				  "bsc_cs6a", "bsc"),
+	PIN_MAP_MUX_GROUP_DEFAULT("pfc-r8a7740", "pfc-r8a7740",
 				  "intc_irq10", "intc"),
 };
 
@@ -419,13 +425,6 @@ static void __init bonito_init(void)
 		u16 bsw3;
 		u16 bsw4;
 
-		/*
-		 * FPGA
-		 */
-		gpio_request(GPIO_FN_CS5B,		NULL);
-		gpio_request(GPIO_FN_CS6A,		NULL);
-		gpio_request(GPIO_FN_CS5A_PORT105,	NULL);
-
 		val = bonito_fpga_read(BVERR);
 		pr_info("bonito version: cpu %02x, base %02x\n",
 			((val >> 8) & 0xFF),
-- 
1.8.2.1

From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 20:06:31 +0900
Subject: [PATCH 095/142] ARM: shmobile: kzm9g: Register pinctrl mappings for
 BSC
In-Reply-To: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
References: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363604838-29359-96-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Replace the GPIO-based BSC pinmux configuration by pinctrl mappings.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-kzm9g.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-kzm9g.c b/arch/arm/mach-shmobile/board-kzm9g.c
index 335bdbb..7427041 100644
--- a/arch/arm/mach-shmobile/board-kzm9g.c
+++ b/arch/arm/mach-shmobile/board-kzm9g.c
@@ -651,6 +651,9 @@ static const struct pinctrl_map kzm_pinctrl_map[] = {
 				  "sdhi2_data4", "sdhi2"),
 	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.2", "pfc-sh73a0",
 				  "sdhi2_ctrl", "sdhi2"),
+	/* SMSC */
+	PIN_MAP_MUX_GROUP_DEFAULT("smsc911x.0", "pfc-sh73a0",
+				  "bsc_cs4", "bsc"),
 };
 
 /*
@@ -718,9 +721,6 @@ static void __init kzm_init(void)
 
 	sh73a0_pinmux_init();
 
-	/* CS4 for SMSC/USB */
-	gpio_request(GPIO_FN_CS4_, NULL); /* CS4 */
-
 	/* SMSC */
 	gpio_request_one(224, GPIOF_IN, NULL); /* IRQ3 */
 
-- 
1.7.10.4

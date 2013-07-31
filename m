From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 31 Jul 2013 10:33:49 +0900
Subject: [PATCH 1/4] ARM: shmobile: armadillo800eva: Don't request GPIO 166 in
 board code
In-Reply-To: <cover.1375234088.git.horms+renesas@verge.net.au>
References: <cover.1375234088.git.horms+renesas@verge.net.au>
Message-ID: <16b551dd22cc7edacb952f7a2e175f36c3aa4bdb.1375234088.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

89ae7b5bbd3e65bc6ab7a577ca5ec18569589c8c
(ARM: shmobile: armadillo800eva: Register pinctrl mapping for INTC)
mistakenly requests GPIO 166 in board code,
most probably due to a wrong merge conflict resolution.
As the GPIO is passed to the st1232 driver through platform
data and requested by the driver,
there's no need to request it in board code. Fix it.

Tested by: Cao Minh Hiep <cm-hiep@jinso.co.jp>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-armadillo800eva.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index e115f67..c5be60d 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -1162,9 +1162,6 @@ static void __init eva_init(void)
 	gpio_request_one(61, GPIOF_OUT_INIT_HIGH, NULL); /* LCDDON */
 	gpio_request_one(202, GPIOF_OUT_INIT_LOW, NULL); /* LCD0_LED_CONT */
 
-	/* Touchscreen */
-	gpio_request_one(166, GPIOF_OUT_INIT_HIGH, NULL); /* TP_RST_B */
-
 	/* GETHER */
 	gpio_request_one(18, GPIOF_OUT_INIT_HIGH, NULL); /* PHY_RST */
 
-- 
1.8.3.2

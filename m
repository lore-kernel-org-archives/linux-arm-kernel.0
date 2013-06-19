From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 19 Jun 2013 22:22:34 +0900
Subject: [PATCH 3/4] pinctrl: r8a7790: fix two pin numbers
In-Reply-To: <1371648155-18479-1-git-send-email-horms+renesas@verge.net.au>
References: <1371648155-18479-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1371648155-18479-4-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Fix two erroneous MMCIF1 pin numbers on r8a7790.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
index 1e7a5eb..14f3ec2 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
@@ -2506,8 +2506,7 @@ static const unsigned int tpu0_to3_pins[] = {
 static const unsigned int tpu0_to3_mux[] = {
 	TPU0TO3_MARK,
 };
-
-/* - MMCIF ------------------------------------------------------------------ */
+/* - MMCIF0 ----------------------------------------------------------------- */
 static const unsigned int mmc0_data1_pins[] = {
 	/* D[0] */
 	RCAR_GP_PIN(3, 18),
@@ -2541,7 +2540,7 @@ static const unsigned int mmc0_ctrl_pins[] = {
 static const unsigned int mmc0_ctrl_mux[] = {
 	MMC0_CLK_MARK, MMC0_CMD_MARK,
 };
-
+/* - MMCIF1 ----------------------------------------------------------------- */
 static const unsigned int mmc1_data1_pins[] = {
 	/* D[0] */
 	RCAR_GP_PIN(3, 26),
@@ -2562,7 +2561,7 @@ static const unsigned int mmc1_data8_pins[] = {
 	RCAR_GP_PIN(3, 26), RCAR_GP_PIN(3, 27),
 	RCAR_GP_PIN(3, 28), RCAR_GP_PIN(3, 29),
 	RCAR_GP_PIN(3, 30), RCAR_GP_PIN(3, 31),
-	RCAR_GP_PIN(3, 13), RCAR_GP_PIN(3, 14),
+	RCAR_GP_PIN(3, 14), RCAR_GP_PIN(3, 15),
 };
 static const unsigned int mmc1_data8_mux[] = {
 	MMC1_D0_MARK, MMC1_D1_MARK, MMC1_D2_MARK, MMC1_D3_MARK,
@@ -2575,8 +2574,7 @@ static const unsigned int mmc1_ctrl_pins[] = {
 static const unsigned int mmc1_ctrl_mux[] = {
 	MMC1_CLK_MARK, MMC1_CMD_MARK,
 };
-
-/* - SDHI ------------------------------------------------------------------- */
+/* - SDHI0 ------------------------------------------------------------------ */
 static const unsigned int sdhi0_data1_pins[] = {
 	/* D0 */
 	RCAR_GP_PIN(3, 2),
@@ -2612,7 +2610,7 @@ static const unsigned int sdhi0_wp_pins[] = {
 static const unsigned int sdhi0_wp_mux[] = {
 	SD0_WP_MARK,
 };
-
+/* - SDHI1 ------------------------------------------------------------------ */
 static const unsigned int sdhi1_data1_pins[] = {
 	/* D0 */
 	RCAR_GP_PIN(3, 10),
@@ -2648,7 +2646,7 @@ static const unsigned int sdhi1_wp_pins[] = {
 static const unsigned int sdhi1_wp_mux[] = {
 	SD1_WP_MARK,
 };
-
+/* - SDHI2 ------------------------------------------------------------------ */
 static const unsigned int sdhi2_data1_pins[] = {
 	/* D0 */
 	RCAR_GP_PIN(3, 18),
@@ -2684,7 +2682,7 @@ static const unsigned int sdhi2_wp_pins[] = {
 static const unsigned int sdhi2_wp_mux[] = {
 	SD2_WP_MARK,
 };
-
+/* - SDHI3 ------------------------------------------------------------------ */
 static const unsigned int sdhi3_data1_pins[] = {
 	/* D0 */
 	RCAR_GP_PIN(3, 26),
-- 
1.8.2.1

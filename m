From: denis@eukrea.com (Denis Carikli)
Date: Fri, 21 Feb 2014 15:00:00 +0100
Subject: [PATCHv7][ 3/7] staging: imx-drm: Correct BGR666 and the board's dts
 that use them.
In-Reply-To: <1392991205-25371-1-git-send-email-denis@eukrea.com>
References: <1392991205-25371-1-git-send-email-denis@eukrea.com>
Message-ID: <1392991205-25371-3-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current BGR666 is not consistent with the other color mapings like BGR24.
BGR666 should be in the same byte order than BGR24.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Eric B?nard <eric@eukrea.com>
Cc: Marek Vasut <marex@denx.de>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: devel at driverdev.osuosl.org
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Denis Carikli <denis@eukrea.com>
---
ChangeLog v6->v7:
- Shrinked even more the Cc list.

ChangeLog v5->v6:
- Remove people not concerned by this patch from the Cc list.
- Added a better explanation of the change.

ChangeLog v5:
- New patch.
---
 arch/arm/boot/dts/imx51-apf51dev.dts    |    2 +-
 arch/arm/boot/dts/imx53-m53evk.dts      |    2 +-
 drivers/staging/imx-drm/ipu-v3/ipu-dc.c |    4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx51-apf51dev.dts b/arch/arm/boot/dts/imx51-apf51dev.dts
index c29cfa9..bff3201 100644
--- a/arch/arm/boot/dts/imx51-apf51dev.dts
+++ b/arch/arm/boot/dts/imx51-apf51dev.dts
@@ -19,7 +19,7 @@
 	display at di1 {
 		compatible = "fsl,imx-parallel-display";
 		crtcs = <&ipu 0>;
-		interface-pix-fmt = "bgr666";
+		interface-pix-fmt = "rgb666";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_ipu_disp1>;
 
diff --git a/arch/arm/boot/dts/imx53-m53evk.dts b/arch/arm/boot/dts/imx53-m53evk.dts
index e8d11e2..a984498 100644
--- a/arch/arm/boot/dts/imx53-m53evk.dts
+++ b/arch/arm/boot/dts/imx53-m53evk.dts
@@ -24,7 +24,7 @@
 		display at di1 {
 			compatible = "fsl,imx-parallel-display";
 			crtcs = <&ipu 1>;
-			interface-pix-fmt = "bgr666";
+			interface-pix-fmt = "rgb666";
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_ipu_disp1>;
 
diff --git a/drivers/staging/imx-drm/ipu-v3/ipu-dc.c b/drivers/staging/imx-drm/ipu-v3/ipu-dc.c
index 617e65b..b11a2aa 100644
--- a/drivers/staging/imx-drm/ipu-v3/ipu-dc.c
+++ b/drivers/staging/imx-drm/ipu-v3/ipu-dc.c
@@ -397,9 +397,9 @@ int ipu_dc_init(struct ipu_soc *ipu, struct device *dev,
 
 	/* bgr666 */
 	ipu_dc_map_clear(priv, IPU_DC_MAP_BGR666);
-	ipu_dc_map_config(priv, IPU_DC_MAP_BGR666, 0, 5, 0xfc); /* blue */
+	ipu_dc_map_config(priv, IPU_DC_MAP_BGR666, 0, 17, 0xfc); /* blue */
 	ipu_dc_map_config(priv, IPU_DC_MAP_BGR666, 1, 11, 0xfc); /* green */
-	ipu_dc_map_config(priv, IPU_DC_MAP_BGR666, 2, 17, 0xfc); /* red */
+	ipu_dc_map_config(priv, IPU_DC_MAP_BGR666, 2, 5, 0xfc); /* red */
 
 	/* bgr24 */
 	ipu_dc_map_clear(priv, IPU_DC_MAP_BGR24);
-- 
1.7.9.5

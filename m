From: philippe.retornaz@epfl.ch (=?UTF-8?q?Philippe=20R=C3=A9tornaz?=)
Date: Tue,  1 Oct 2013 14:36:11 +0200
Subject: [PATCH 2/2] ASoC: fsl: Fix sound on mx31moboard
In-Reply-To: <1380630971-11431-2-git-send-email-philippe.retornaz@epfl.ch>
References: <1380630971-11431-1-git-send-email-philippe.retornaz@epfl.ch>
 <1380630971-11431-2-git-send-email-philippe.retornaz@epfl.ch>
Message-ID: <1380630971-11431-3-git-send-email-philippe.retornaz@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 42810d (ASoC: imx-mc13783: Add audmux settings for mx27pdk) broke
the sound on mx31moboard. Restore back the audmux setting on such boards.

Signed-off-by: Philippe R?tornaz <philippe.retornaz@epfl.ch>
---
 sound/soc/fsl/imx-mc13783.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/imx-mc13783.c b/sound/soc/fsl/imx-mc13783.c
index a3d60d4..a2fd732 100644
--- a/sound/soc/fsl/imx-mc13783.c
+++ b/sound/soc/fsl/imx-mc13783.c
@@ -112,7 +112,7 @@ static int imx_mc13783_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	if (machine_is_mx31_3ds()) {
+	if (machine_is_mx31_3ds() || machine_is_mx31moboard()) {
 		imx_audmux_v2_configure_port(MX31_AUDMUX_PORT4_SSI_PINS_4,
 			IMX_AUDMUX_V2_PTCR_SYN,
 			IMX_AUDMUX_V2_PDCR_RXDSEL(MX31_AUDMUX_PORT1_SSI0) |
-- 
1.7.9.5

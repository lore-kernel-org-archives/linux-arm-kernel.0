From: mpa@pengutronix.de (Markus Pargmann)
Date: Sun, 10 Mar 2013 19:33:03 +0100
Subject: [PATCH 02/10] imx-ssi: Fix occasional AC97 reset failure
In-Reply-To: <1362940391-8338-1-git-send-email-mpa@pengutronix.de>
References: <1362940391-8338-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1362940391-8338-3-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sascha Hauer <s.hauer@pengutronix.de>

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 sound/soc/fsl/imx-ssi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/fsl/imx-ssi.c b/sound/soc/fsl/imx-ssi.c
index 7ee0147..0e3fc8d 100644
--- a/sound/soc/fsl/imx-ssi.c
+++ b/sound/soc/fsl/imx-ssi.c
@@ -496,6 +496,8 @@ static void imx_ssi_ac97_reset(struct snd_ac97 *ac97)
 
 	if (imx_ssi->ac97_reset)
 		imx_ssi->ac97_reset(ac97);
+	/* First read sometimes fails, do a dummy read */
+	imx_ssi_ac97_read(ac97, 0);
 }
 
 static void imx_ssi_ac97_warm_reset(struct snd_ac97 *ac97)
@@ -504,6 +506,9 @@ static void imx_ssi_ac97_warm_reset(struct snd_ac97 *ac97)
 
 	if (imx_ssi->ac97_warm_reset)
 		imx_ssi->ac97_warm_reset(ac97);
+
+	/* First read sometimes fails, do a dummy read */
+	imx_ssi_ac97_read(ac97, 0);
 }
 
 struct snd_ac97_bus_ops soc_ac97_ops = {
-- 
1.8.1.5

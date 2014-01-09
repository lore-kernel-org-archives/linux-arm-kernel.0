From: mpa@pengutronix.de (Markus Pargmann)
Date: Thu,  9 Jan 2014 11:16:11 +0100
Subject: [PATCH 2/2] ASoC: fsl-ssi: Fix stats compile warning
In-Reply-To: <1389262571-12489-1-git-send-email-mpa@pengutronix.de>
References: <20140108172144.GP31886@sirena.org.uk>
 <1389262571-12489-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1389262571-12489-3-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

single_open requires a function with signature
'int (*)(struct seq_file *, void *)'. This patch fixes the warning by
fixing the wrong return type of fsl_ssi_stats_show.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 sound/soc/fsl/fsl_ssi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index e40bce1..cb4c2e0 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -391,7 +391,7 @@ static irqreturn_t fsl_ssi_isr(int irq, void *dev_id)
  * Display the statistics for the current SSI device.  To avoid confusion,
  * we only show those counts that are enabled.
  */
-static ssize_t fsl_ssi_stats_show(struct seq_file *s, void *unused)
+static int fsl_ssi_stats_show(struct seq_file *s, void *unused)
 {
 	struct fsl_ssi_private *ssi_private = s->private;
 
-- 
1.8.5.2

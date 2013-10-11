From: mpa@pengutronix.de (Markus Pargmann)
Date: Fri, 11 Oct 2013 12:11:02 +0200
Subject: [PATCH 1/3] ASoC: snd_soc_dai_ops trigger function description
In-Reply-To: <1381486264-1672-1-git-send-email-mpa@pengutronix.de>
References: <1381486264-1672-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1381486264-1672-2-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a comment to the trigger function in snd_soc_dai_ops struct about
possible command sequences.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 include/sound/soc-dai.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index ae9a227..0f2e5da 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -166,6 +166,13 @@ struct snd_soc_dai_ops {
 		struct snd_soc_dai *);
 	int (*prepare)(struct snd_pcm_substream *,
 		struct snd_soc_dai *);
+	/*
+	 * NOTE: Commands passed to the trigger function are not necessarily
+	 * compatible with the current state of the dai. For example this
+	 * sequence of commands is possible: START STOP STOP.
+	 * So do not unconditionally use refcounting functions in the trigger
+	 * function, e.g. clk_enable/disable.
+	 */
 	int (*trigger)(struct snd_pcm_substream *, int,
 		struct snd_soc_dai *);
 	int (*bespoke_trigger)(struct snd_pcm_substream *, int,
-- 
1.8.4.rc3

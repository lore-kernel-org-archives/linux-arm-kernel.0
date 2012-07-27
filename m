From: b29396@freescale.com (Dong Aisheng)
Date: Fri, 27 Jul 2012 19:19:01 +0800
Subject: [RFC PATCH 1/1] ASoC: soc-dapm: warn if no avaiable path found for
 widget kcontrol
Message-ID: <1343387941-25266-1-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dong Aisheng <dong.aisheng@linaro.org>

This could help people know what's wrong going on if the required
path is not registered.

Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
---
 sound/soc/soc-dapm.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 4d181df..b9b94c5 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1879,6 +1879,9 @@ static int soc_dapm_mux_update_power(struct snd_soc_dapm_widget *widget,
 		}
 	}
 
+	WARN(!found, "did not find dapm widget path associated with kcontrol %s\n",
+		kcontrol->id.name);
+
 	if (found) {
 		dapm_mark_dirty(widget, "mux change");
 		dapm_power_widgets(widget->dapm, SND_SOC_DAPM_STREAM_NOP);
-- 
1.7.0.4

From: lori.hikichi@broadcom.com (Lori Hikichi)
Date: Mon, 14 Aug 2017 15:06:56 -0700
Subject: [PATCH 8/9] ASoC: cygnus: Add EXPORT_SYMBOL for helper function
In-Reply-To: <1502748417-26417-1-git-send-email-lori.hikichi@broadcom.com>
References: <1502748417-26417-1-git-send-email-lori.hikichi@broadcom.com>
Message-ID: <1502748417-26417-9-git-send-email-lori.hikichi@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The helper function cygnus_ssp_set_custom_fsync_width() is intended
to be called from an ASoC machine driver, need to export symbol
if using modules.

Signed-off-by: Lori Hikichi <lori.hikichi@broadcom.com>
---
 sound/soc/bcm/cygnus-ssp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/bcm/cygnus-ssp.c b/sound/soc/bcm/cygnus-ssp.c
index e72d8a8..97bf67a 100644
--- a/sound/soc/bcm/cygnus-ssp.c
+++ b/sound/soc/bcm/cygnus-ssp.c
@@ -875,6 +875,7 @@ int cygnus_ssp_set_custom_fsync_width(struct snd_soc_dai *cpu_dai, int len)
 		return -EINVAL;
 	}
 }
+EXPORT_SYMBOL_GPL(cygnus_ssp_set_custom_fsync_width);
 
 static int cygnus_ssp_set_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
 {
-- 
1.9.1

From: lori.hikichi@broadcom.com (Lori Hikichi)
Date: Thu, 28 Sep 2017 15:29:32 -0700
Subject: [PATCH v1 1/3] ASoC: cygnus: Add EXPORT_SYMBOL for helper function
In-Reply-To: <1506637775-18293-1-git-send-email-lori.hikichi@broadcom.com>
References: <1506637775-18293-1-git-send-email-lori.hikichi@broadcom.com>
Message-ID: <1506637775-18293-2-git-send-email-lori.hikichi@broadcom.com>
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
index 15c438f..e9c73a4 100644
--- a/sound/soc/bcm/cygnus-ssp.c
+++ b/sound/soc/bcm/cygnus-ssp.c
@@ -842,6 +842,7 @@ int cygnus_ssp_set_custom_fsync_width(struct snd_soc_dai *cpu_dai, int len)
 		return -EINVAL;
 	}
 }
+EXPORT_SYMBOL_GPL(cygnus_ssp_set_custom_fsync_width);
 
 static int cygnus_ssp_set_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
 {
-- 
1.9.1

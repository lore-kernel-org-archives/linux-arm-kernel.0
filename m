From: broonie@kernel.org (Mark Brown)
Date: Wed, 04 Oct 2017 12:27:56 +0100
Subject: Applied "ASoC: cygnus: Add EXPORT_SYMBOL for helper function" to the
 asoc tree
In-Reply-To: <1502748417-26417-9-git-send-email-lori.hikichi@broadcom.com>
Message-ID: <E1dzhqG-0004Fb-As@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: cygnus: Add EXPORT_SYMBOL for helper function

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From d8302aa6b53acbe421fe615b9d704fd813623e96 Mon Sep 17 00:00:00 2001
From: Lori Hikichi <lori.hikichi@broadcom.com>
Date: Thu, 28 Sep 2017 15:29:32 -0700
Subject: [PATCH] ASoC: cygnus: Add EXPORT_SYMBOL for helper function

The helper function cygnus_ssp_set_custom_fsync_width() is intended
to be called from an ASoC machine driver, need to export symbol
if using modules.

Signed-off-by: Lori Hikichi <lori.hikichi@broadcom.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/bcm/cygnus-ssp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/bcm/cygnus-ssp.c b/sound/soc/bcm/cygnus-ssp.c
index 15c438f0f22d..e9c73a451cf6 100644
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
2.14.1

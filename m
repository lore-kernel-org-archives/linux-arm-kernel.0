From: broonie@kernel.org (Mark Brown)
Date: Mon, 04 Sep 2017 18:25:29 +0100
Subject: Applied "ASoC: add new ac97 bus support" to the asoc tree
In-Reply-To: <20170724204928.29505-4-robert.jarzmik@free.fr>
Message-ID: <E1dov7p-0003uP-6C@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: add new ac97 bus support

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

>From 8d43344108c9945456128b75b69beee594b64ed6 Mon Sep 17 00:00:00 2001
From: Robert Jarzmik <robert.jarzmik@free.fr>
Date: Sat, 2 Sep 2017 21:54:05 +0200
Subject: [PATCH] ASoC: add new ac97 bus support

Add the new ac97 bus support, with ac97 bus automatic probing.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/Kconfig  | 2 ++
 sound/Makefile | 1 +
 2 files changed, 3 insertions(+)

diff --git a/sound/Kconfig b/sound/Kconfig
index d7d2aac9542e..ed34218d38b8 100644
--- a/sound/Kconfig
+++ b/sound/Kconfig
@@ -80,6 +80,8 @@ source "sound/hda/Kconfig"
 
 source "sound/ppc/Kconfig"
 
+source "sound/ac97/Kconfig"
+
 source "sound/aoa/Kconfig"
 
 source "sound/arm/Kconfig"
diff --git a/sound/Makefile b/sound/Makefile
index 6de45d2c32f7..c03b0bed65d5 100644
--- a/sound/Makefile
+++ b/sound/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_SND_AOA) += aoa/
 
 # This one must be compilable even if sound is configured out
 obj-$(CONFIG_AC97_BUS) += ac97_bus.o
+obj-$(CONFIG_AC97_BUS_NEW) += ac97/
 
 ifeq ($(CONFIG_SND),y)
   obj-y += last.o
-- 
2.14.1

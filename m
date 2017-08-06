From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sun,  6 Aug 2017 23:36:04 +0200
Subject: [PATCH v5 03/12] ASoC: add new ac97 bus support
In-Reply-To: <20170806213613.5600-1-robert.jarzmik@free.fr>
References: <20170806213613.5600-1-robert.jarzmik@free.fr>
Message-ID: <20170806213613.5600-4-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the new ac97 bus support, with ac97 bus automatic probing.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/Kconfig  | 2 ++
 sound/Makefile | 1 +
 2 files changed, 3 insertions(+)

diff --git a/sound/Kconfig b/sound/Kconfig
index ee2e69a9ecd1..141b145c4195 100644
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
2.11.0

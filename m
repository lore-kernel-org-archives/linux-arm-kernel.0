From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 10 Jul 2014 23:36:24 +0200
Subject: [PATCH v2 04/12] ASoC: kirkwood: Remove ARCH_KIRKWOOD dependency
In-Reply-To: <1405028192-9623-1-git-send-email-andrew@lunn.ch>
References: <1405028192-9623-1-git-send-email-andrew@lunn.ch>
Message-ID: <1405028192-9623-5-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mach-kirkwood has been removed, now that kirkwood lives in
mach-mvebu. Remove ARCH_KIRKWOOD since ARCH_MVEBU is sufficient.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Cc: Mark Brown <broonie@kernel.org>
Cc: alsa-devel at alsa-project.org
---
 sound/soc/kirkwood/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/kirkwood/Kconfig b/sound/soc/kirkwood/Kconfig
index 1f7c7ee3527a..132bb83f8e99 100644
--- a/sound/soc/kirkwood/Kconfig
+++ b/sound/soc/kirkwood/Kconfig
@@ -1,6 +1,6 @@
 config SND_KIRKWOOD_SOC
 	tristate "SoC Audio for the Marvell Kirkwood and Dove chips"
-	depends on ARCH_KIRKWOOD || ARCH_DOVE || ARCH_MVEBU || MACH_KIRKWOOD || COMPILE_TEST
+	depends on ARCH_DOVE || ARCH_MVEBU || COMPILE_TEST
 	help
 	  Say Y or M if you want to add support for codecs attached to
 	  the Kirkwood I2S interface. You will also need to select the
-- 
2.0.1

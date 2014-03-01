From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sat,  1 Mar 2014 09:33:17 +0100
Subject: [PATCH v2 1/5] ASoC: kirkwood: prepare new Dove DT Kconfig variable
In-Reply-To: <1393536486-3827-3-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1393536486-3827-3-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1393662801-17950-1-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DT-enabled Dove will move over from ARCH_DOVE in mach-dove to MACH_DOVE in
mach-mvebu. As non-DT ARCH_DOVE will stay to rot for a while, add a new
DT-only MACH_DOVE Kconfig.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Mark, as requested, this is the ASoC only patch touching Kconfig for
Marvell Dove to mach-mvebu conversion.

Cc: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: alsa-devel at alsa-project.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 sound/soc/kirkwood/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/kirkwood/Kconfig b/sound/soc/kirkwood/Kconfig
index 78ed4a42ad21..a1506d57e646 100644
--- a/sound/soc/kirkwood/Kconfig
+++ b/sound/soc/kirkwood/Kconfig
@@ -1,6 +1,6 @@
 config SND_KIRKWOOD_SOC
 	tristate "SoC Audio for the Marvell Kirkwood and Dove chips"
-	depends on ARCH_KIRKWOOD || ARCH_DOVE || COMPILE_TEST
+	depends on ARCH_KIRKWOOD || ARCH_DOVE || MACH_DOVE || COMPILE_TEST
 	help
 	  Say Y or M if you want to add support for codecs attached to
 	  the Kirkwood I2S interface. You will also need to select the
-- 
1.8.5.3

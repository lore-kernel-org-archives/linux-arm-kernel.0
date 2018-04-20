From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 20 Apr 2018 15:28:32 +0200
Subject: [PATCH 6/8] ASoC: sh: Update menu title and platform dependency
In-Reply-To: <1524230914-10175-1-git-send-email-geert+renesas@glider.be>
References: <1524230914-10175-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1524230914-10175-7-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change the menu title to refer to "Renesas SoCs" instead of "SuperH", as
both SuperH and ARM SoCs are supported.

Since commit 9b5ba0df4ea4f940 ("ARM: shmobile: Introduce ARCH_RENESAS")
is ARCH_RENESAS a more appropriate platform dependency for Renesas ARM
SoCs than the legacy ARCH_SHMOBILE, hence use the former.
Renesas SuperH SH-Mobile SoCs are still covered by the SUPERH
dependency.

This will allow to drop ARCH_SHMOBILE on ARM and ARM64 in the near
future.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 sound/soc/sh/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sh/Kconfig b/sound/soc/sh/Kconfig
index 1aa5cd77ca24a06f..c1b7fb91e3063f2b 100644
--- a/sound/soc/sh/Kconfig
+++ b/sound/soc/sh/Kconfig
@@ -1,5 +1,5 @@
-menu "SoC Audio support for SuperH"
-	depends on SUPERH || ARCH_SHMOBILE || COMPILE_TEST
+menu "SoC Audio support for Renesas SoCs"
+	depends on SUPERH || ARCH_RENESAS || COMPILE_TEST
 
 config SND_SOC_PCM_SH7760
 	tristate "SoC Audio support for Renesas SH7760"
-- 
2.7.4

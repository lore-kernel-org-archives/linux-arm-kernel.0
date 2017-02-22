From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Wed, 22 Feb 2017 03:29:24 +0100
Subject: [PATCH v2 4/8] sound: soc: pxa: Suppress SND_MMP_SOC for arm64
In-Reply-To: <20170222022929.10540-1-afaerber@suse.de>
References: <20170222022929.10540-1-afaerber@suse.de>
Message-ID: <20170222022929.10540-5-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SND_MMP_SOC selects SND_ARM, which is limited to ARM, as well as
MMP_SRAM, which is a non-DT driver in arch/arm/mach-arm/.

Avoid Kconfig warnings by not making this driver available on ARM64.

While at it, tidy the title (Soc -> SoC).

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v2: new
 
 sound/soc/pxa/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/pxa/Kconfig b/sound/soc/pxa/Kconfig
index 823b5a2..f8e1c06 100644
--- a/sound/soc/pxa/Kconfig
+++ b/sound/soc/pxa/Kconfig
@@ -8,8 +8,8 @@ config SND_PXA2XX_SOC
 	  to select the audio interfaces to support below.
 
 config SND_MMP_SOC
-	bool "Soc Audio for Marvell MMP chips"
-	depends on ARCH_MMP
+	bool "SoC Audio for Marvell MMP chips"
+	depends on ARCH_MMP && ARM
 	select MMP_SRAM
 	select SND_SOC_GENERIC_DMAENGINE_PCM
 	select SND_ARM
-- 
2.10.2

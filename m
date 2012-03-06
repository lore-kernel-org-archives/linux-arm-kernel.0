From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Tue,  6 Mar 2012 14:35:14 +0200
Subject: [PATCH 3/5] Revert "ASoC: Remove twl6040 dependency on twl4030 from
 Kconfig"
In-Reply-To: <1331037316-7375-1-git-send-email-peter.ujfalusi@ti.com>
References: <1331037316-7375-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1331037316-7375-4-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reverts commit 36229729d92f903a7311f1c040b33d5bab0af60b.

Reverting changes regarding to twl6040 in MFD tree since the patches will go
via the audio tree.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index f1a1197..7c205e7 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -56,7 +56,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_TPA6130A2 if I2C
 	select SND_SOC_TLV320DAC33 if I2C
 	select SND_SOC_TWL4030 if TWL4030_CORE
-	select SND_SOC_TWL6040 if I2C
+	select SND_SOC_TWL6040 if TWL4030_CORE
 	select SND_SOC_UDA134X
 	select SND_SOC_UDA1380 if I2C
 	select SND_SOC_WL1273 if MFD_WL1273_CORE
-- 
1.7.8.5

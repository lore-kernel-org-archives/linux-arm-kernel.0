From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sat, 19 Nov 2016 16:48:26 +0200
Subject: [PATCH 1/6] ASoC: samsung: Remove non-existing MACH dependencies
In-Reply-To: <1479566911-5580-1-git-send-email-krzk@kernel.org>
References: <1479566911-5580-1-git-send-email-krzk@kernel.org>
Message-ID: <1479566911-5580-2-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MACH_SMDKC100 was removed in commit b8529ec1c1b0 ("ARM: S5PC100: no more
support S5PC100 SoC"). MACH_SMDKV210 and MACH_SMDKC110 in commit
28c8331d386 ("ARM: S5PV210: Remove support for board files").

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/samsung/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/samsung/Kconfig b/sound/soc/samsung/Kconfig
index 79ae6a7c93ff..ea0fa9971a0c 100644
--- a/sound/soc/samsung/Kconfig
+++ b/sound/soc/samsung/Kconfig
@@ -49,7 +49,7 @@ config SND_SOC_SAMSUNG_JIVE_WM8750
 
 config SND_SOC_SAMSUNG_SMDK_WM8580
 	tristate "SoC I2S Audio support for WM8580 on SMDK"
-	depends on MACH_SMDK6410 || MACH_SMDKC100 || MACH_SMDKV210 || MACH_SMDKC110
+	depends on MACH_SMDK6410
 	depends on I2C
 	select SND_SOC_WM8580
 	select SND_SAMSUNG_I2S
-- 
2.7.4

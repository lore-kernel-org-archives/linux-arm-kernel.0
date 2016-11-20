From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sun, 20 Nov 2016 21:24:54 +0200
Subject: [PATCH v2 4/5] ASoC: samsung: Enable COMPILE_TEST for entire Samsung
 ASoc
In-Reply-To: <1479669895-19124-1-git-send-email-krzk@kernel.org>
References: <1479669895-19124-1-git-send-email-krzk@kernel.org>
Message-ID: <1479669895-19124-5-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of build time, Samsung ASoC drivers have rather runtime
dependency on Exynos or other Samsung platforms.  For building they
require Common Clock Framework.  If it is provided they could be compile
tested to increase build coverage.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/samsung/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/samsung/Kconfig b/sound/soc/samsung/Kconfig
index 426ef1c7b265..a6cc6ca93fa7 100644
--- a/sound/soc/samsung/Kconfig
+++ b/sound/soc/samsung/Kconfig
@@ -1,6 +1,7 @@
 menuconfig SND_SOC_SAMSUNG
 	tristate "ASoC support for Samsung"
-	depends on (PLAT_SAMSUNG || ARCH_EXYNOS)
+	depends on PLAT_SAMSUNG || ARCH_EXYNOS || COMPILE_TEST
+	depends on COMMON_CLK
 	select SND_SOC_GENERIC_DMAENGINE_PCM
 	---help---
 	  Say Y or M if you want to add support for codecs attached to
-- 
2.7.4

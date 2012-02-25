From: mathieu.poirier@linaro.org (mathieu.poirier at linaro.org)
Date: Sat, 25 Feb 2012 12:55:05 -0700
Subject: [PATCH 4/6] ARM: ux500: select L2X0 cache on ux500
In-Reply-To: <1330199707-5179-1-git-send-email-mathieu.poirier@linaro.org>
References: <1330199707-5179-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1330199707-5179-4-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>

The cache controller needs to be enabled for the
cortex-a9 specific errata that are also selected
to work.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 arch/arm/mach-ux500/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-ux500/Kconfig b/arch/arm/mach-ux500/Kconfig
index 50010b8..7ee7013 100644
--- a/arch/arm/mach-ux500/Kconfig
+++ b/arch/arm/mach-ux500/Kconfig
@@ -8,6 +8,7 @@ config UX500_SOC_COMMON
 	select ARM_ERRATA_753970
 	select ARM_ERRATA_754322
 	select ARM_ERRATA_764369
+	select CACHE_L2X0
 
 config UX500_SOC_DB5500
 	bool
-- 
1.7.5.4

From: mathieu.poirier@linaro.org (mathieu.poirier at linaro.org)
Date: Fri, 23 Mar 2012 11:13:55 -0600
Subject: [PATCH 8/9] arm: OMAP depends on MMU
In-Reply-To: <1332522836-29517-1-git-send-email-mathieu.poirier@linaro.org>
References: <1332522836-29517-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1332522836-29517-9-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>

There is no way to build OMAP kernels without an MMU
at this point because of dependencies on MMU-only functions.

As long as nobody is interested in fixing this, let's just disable
this platforms for nommu kernels.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index dfb0312..8124ce0 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -939,6 +939,7 @@ config ARCH_DAVINCI
 
 config ARCH_OMAP
 	bool "TI OMAP"
+	depends on MMU
 	select HAVE_CLK
 	select ARCH_REQUIRE_GPIOLIB
 	select ARCH_HAS_CPUFREQ
-- 
1.7.5.4

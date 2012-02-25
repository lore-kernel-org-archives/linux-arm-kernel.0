From: mathieu.poirier@linaro.org (mathieu.poirier at linaro.org)
Date: Sat, 25 Feb 2012 12:55:06 -0700
Subject: [PATCH 5/6] ARM: ux500: select CPU_FREQ_TABLE where needed
In-Reply-To: <1330199707-5179-1-git-send-email-mathieu.poirier@linaro.org>
References: <1330199707-5179-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1330199707-5179-5-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>

The ux500 platform requires CPU_FREQ_TABLE support to be enabled for its
CPU_FREQ implementations, so automatically select that when CPU_FREQ
is enabled.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 arch/arm/mach-ux500/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-ux500/Kconfig b/arch/arm/mach-ux500/Kconfig
index 7ee7013..c7d1fb5 100644
--- a/arch/arm/mach-ux500/Kconfig
+++ b/arch/arm/mach-ux500/Kconfig
@@ -20,6 +20,7 @@ config UX500_SOC_DB8500
 	select MFD_DB8500_PRCMU
 	select REGULATOR_DB8500_PRCMU
 	select MFD_SUPPORT
+	select CPU_FREQ_TABLE if CPU_FREQ
 
 menu "Ux500 target platform (boards)"
 
-- 
1.7.5.4

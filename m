From: mathieu.poirier@linaro.org (mathieu.poirier at linaro.org)
Date: Sat, 25 Feb 2012 12:55:04 -0700
Subject: [PATCH 3/6] ux500: select MFD_SUPPORT when needed
In-Reply-To: <1330199707-5179-1-git-send-email-mathieu.poirier@linaro.org>
References: <1330199707-5179-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1330199707-5179-3-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>

When the MFD_DBx500_PRCMU driver is selected, we
also need to select MFD_SUPPORT to guarantee a
successful build.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 arch/arm/mach-ux500/Kconfig |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-ux500/Kconfig b/arch/arm/mach-ux500/Kconfig
index dc488de..50010b8 100644
--- a/arch/arm/mach-ux500/Kconfig
+++ b/arch/arm/mach-ux500/Kconfig
@@ -12,11 +12,13 @@ config UX500_SOC_COMMON
 config UX500_SOC_DB5500
 	bool
 	select MFD_DB5500_PRCMU
+	select MFD_SUPPORT
 
 config UX500_SOC_DB8500
 	bool
 	select MFD_DB8500_PRCMU
 	select REGULATOR_DB8500_PRCMU
+	select MFD_SUPPORT
 
 menu "Ux500 target platform (boards)"
 
-- 
1.7.5.4

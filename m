From: khilman@ti.com (Kevin Hilman)
Date: Thu,  4 Aug 2011 08:45:05 -0700
Subject: [PATCH 1/6] OMAP2+: Kconfig: don't select PM in OMAP2PLUS_TYPICAL
In-Reply-To: <1312472710-31758-1-git-send-email-khilman@ti.com>
References: <1312472710-31758-1-git-send-email-khilman@ti.com>
Message-ID: <1312472710-31758-2-git-send-email-khilman@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_PM is no longer a user-selectable Kconfig option.  Rather it is
automatically enabled if either CONFIG_SUSPEND or CONFIG_RUNTIME_PM is
enabled, so having a 'select PM' here is redunant when 'select
CONFIG_PM_RUNTIME' is present.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/Kconfig |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 4ae6257..57b66d5 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -7,7 +7,6 @@ config ARCH_OMAP2PLUS_TYPICAL
 	default y
 	select AEABI
 	select REGULATOR
-	select PM
 	select PM_RUNTIME
 	select VFP
 	select NEON if ARCH_OMAP3 || ARCH_OMAP4
-- 
1.7.6

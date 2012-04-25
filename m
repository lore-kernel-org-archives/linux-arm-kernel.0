From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 25 Apr 2012 13:20:50 -0600
Subject: [PATCH] ARM: disable SUSPEND/ARCH_SUSPEND_POSSIBLE for ARCH_TEGRA
Message-ID: <1335381650-7666-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Tegra doesn't yet support system sleep. Explicitly disable support
for this feature in Kconfig.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
Russell, I assume this should go into the ARM patch tracker?

 arch/arm/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 4f4fead..5bc48d2 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -2243,7 +2243,7 @@ menu "Power management options"
 source "kernel/power/Kconfig"
 
 config ARCH_SUSPEND_POSSIBLE
-	depends on !ARCH_S5PC100
+	depends on !ARCH_S5PC100 && !ARCH_TEGRA
 	depends on CPU_ARM920T || CPU_ARM926T || CPU_SA1100 || \
 		CPU_V6 || CPU_V6K || CPU_V7 || CPU_XSC3 || CPU_XSCALE
 	def_bool y
-- 
1.7.0.4

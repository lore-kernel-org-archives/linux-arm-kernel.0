From: dann.frazier@canonical.com (dann frazier)
Date: Wed, 27 Jan 2016 16:10:30 -0700
Subject: [PATCH] arm64: Disallow combination of ARCH_XGENE and 16K page size
Message-ID: <1453936230-7305-1-git-send-email-dann.frazier@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

16K page size is an optional feature of the architecture, and is not
supported by the X-Gene SoC family.

Signed-off-by: dann frazier <dann.frazier@canonical.com>
---
 arch/arm64/Kconfig.platforms | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 21074f6..b241290 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -133,6 +133,7 @@ config ARCH_VEXPRESS
 
 config ARCH_XGENE
 	bool "AppliedMicro X-Gene SOC Family"
+	depends on !ARM64_16K_PAGES
 	help
 	  This enables support for AppliedMicro X-Gene SOC Family
 
-- 
2.7.0

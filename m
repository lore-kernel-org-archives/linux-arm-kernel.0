From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Fri, 14 Nov 2014 18:00:54 +0530
Subject: [PATCH] arm64: enable ARCH_HAS_BANDGAP config
Message-ID: <1415968254-5182-1-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some of the existing thermal drivers (ti and exynos) have a dependency on
ARCH_HAS_BANDGAP. Activate ARCH_HAS_BANDGAP config entry for ARM64 so that
these drivers may be re-used.

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
---
 arch/arm64/Kconfig |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 5bb1900..7c452e4 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -139,6 +139,9 @@ config KERNEL_MODE_NEON
 config FIX_EARLYCON_MEM
 	def_bool y
 
+config ARCH_HAS_BANDGAP
+	def_bool y
+
 source "init/Kconfig"
 
 source "kernel/Kconfig.freezer"
-- 
1.7.9.5

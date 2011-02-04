From: dave.martin@linaro.org (Dave Martin)
Date: Fri,  4 Feb 2011 14:20:10 +0000
Subject: [PATCH] ARM: Thumb-2: Make CONFIG_OABI_COMPAT depend on
	!CONFIG_THUMB2_KERNEL
Message-ID: <1296829210-21259-1-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

rmk says: "You might as well make OABI_COMPAT depend on !THUMB2_KERNEL.
OABI userland is useless without FPA support."

nwfpe doesn't work with Thumb-2 anyway and will probably never get
ported, so I can't argue with that.

This patch implements the dependency change.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 5cff165..26d45e5 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1391,7 +1391,7 @@ config AEABI
 
 config OABI_COMPAT
 	bool "Allow old ABI binaries to run with this kernel (EXPERIMENTAL)"
-	depends on AEABI && EXPERIMENTAL
+	depends on AEABI && EXPERIMENTAL && !THUMB2_KERNEL
 	default y
 	help
 	  This option preserves the old syscall interface along with the
-- 
1.7.1

From: bamvor.zhangjian@linaro.org (Bamvor Jian Zhang)
Date: Tue, 29 Dec 2015 22:59:42 +0800
Subject: [PATCH] arm64: compat: fix wrong dependency
In-Reply-To: <20151229122721.GA20341@yury-N73SV>
References: <20151229122721.GA20341@yury-N73SV>
Message-ID: <1451401182-10629-1-git-send-email-bamvor.zhangjian@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the patches of ILP32, COMPAT is not equivalent to AARCH32 in EL0.
This patch fix this by updating the dependency from COMPAT to
AARCH32_EL0 for ARMV8_DEPRECATED and ARM64_ERRATUM_845719.

Signed-off-by: Bamvor Jian Zhang <bamvor.zhangjian@linaro.org>
---
 arch/arm64/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index deec37a..7ea783b 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -313,7 +313,7 @@ config ARM64_ERRATUM_832075
 
 config ARM64_ERRATUM_845719
 	bool "Cortex-A53: 845719: a load might read incorrect data"
-	depends on COMPAT
+	depends on AARCH32_EL0
 	default y
 	help
 	  This option adds an alternative code sequence to work around ARM
@@ -509,7 +509,7 @@ config FORCE_MAX_ZONEORDER
 
 menuconfig ARMV8_DEPRECATED
 	bool "Emulate deprecated/obsolete ARMv8 instructions"
-	depends on COMPAT
+	depends on AARCH32_EL0
 	help
 	  Legacy software support may require certain instructions
 	  that have been deprecated or obsoleted in the architecture.
-- 
2.1.4

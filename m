From: ynorov@caviumnetworks.com (Yury Norov)
Date: Thu, 14 Jan 2016 20:23:02 +0300
Subject: [PATCH v6 05/21] arm64: compat: change config dependences to aarch32
In-Reply-To: <1452792198-10718-1-git-send-email-ynorov@caviumnetworks.com>
References: <1452792198-10718-1-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <1452792198-10718-6-git-send-email-ynorov@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bamvor Jian Zhang <bamvor.zhangjian@linaro.org>

With the patches of ILP32, COMPAT is not equivalent to AARCH32 in EL0.
This patch fix this by updating the dependency from COMPAT to
AARCH32_EL0 for ARMV8_DEPRECATED and ARM64_ERRATUM_845719.

Signed-off-by: Bamvor Jian Zhang <bamvor.zhangjian@linaro.org>
Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 arch/arm64/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 09d7b7e..aeddddd 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -339,7 +339,7 @@ config ARM64_ERRATUM_834220
 
 config ARM64_ERRATUM_845719
 	bool "Cortex-A53: 845719: a load might read incorrect data"
-	depends on COMPAT
+	depends on AARCH32_EL0
 	default y
 	help
 	  This option adds an alternative code sequence to work around ARM
@@ -592,7 +592,7 @@ config FORCE_MAX_ZONEORDER
 
 menuconfig ARMV8_DEPRECATED
 	bool "Emulate deprecated/obsolete ARMv8 instructions"
-	depends on COMPAT
+	depends on AARCH32_EL0
 	help
 	  Legacy software support may require certain instructions
 	  that have been deprecated or obsoleted in the architecture.
-- 
2.5.0

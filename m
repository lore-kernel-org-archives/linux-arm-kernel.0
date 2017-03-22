From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 22 Mar 2017 14:50:44 +0000
Subject: [RFC PATCH v2 14/41] Revert "arm64/sve: Allow kernel-mode NEON to be
 disabled in Kconfig"
In-Reply-To: <1490194274-30569-1-git-send-email-Dave.Martin@arm.com>
References: <1490194274-30569-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1490194274-30569-15-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that KERNEL_MODE_NEON works for SVE, we can just default it
back to y.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/Kconfig | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 05b6dd3..593d2db 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -227,6 +227,9 @@ config SWIOTLB
 config IOMMU_HELPER
 	def_bool SWIOTLB
 
+config KERNEL_MODE_NEON
+	def_bool y
+
 config FIX_EARLYCON_MEM
 	def_bool y
 
@@ -272,10 +275,6 @@ endmenu
 
 menu "Kernel Features"
 
-config KERNEL_MODE_NEON
-	bool "Support NEON/FPSIMD code in the kernel"
-	default y
-
 menu "ARM errata workarounds via the alternatives framework"
 
 config ARM64_ERRATUM_826319
-- 
2.1.4

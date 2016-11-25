From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 25 Nov 2016 19:39:02 +0000
Subject: [RFC PATCH 14/29] Revert "arm64/sve: Allow kernel-mode NEON to be
 disabled in Kconfig"
In-Reply-To: <1480102762-23647-1-git-send-email-Dave.Martin@arm.com>
References: <1480102762-23647-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1480102762-23647-15-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that KERNEL_MODE_NEON works for SVE, we can just default it
back to y.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/Kconfig | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 7266761..bf9915cb 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -224,6 +224,9 @@ config SWIOTLB
 config IOMMU_HELPER
 	def_bool SWIOTLB
 
+config KERNEL_MODE_NEON
+	def_bool y
+
 config FIX_EARLYCON_MEM
 	def_bool y
 
@@ -266,10 +269,6 @@ endmenu
 
 menu "Kernel Features"
 
-config KERNEL_MODE_NEON
-	bool "Support NEON/FPSIMD code in the kernel"
-	default y
-
 menu "ARM errata workarounds via the alternatives framework"
 
 config ARM64_ERRATUM_826319
-- 
2.1.4

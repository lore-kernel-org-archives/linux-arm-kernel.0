From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 22 Mar 2017 14:50:37 +0000
Subject: [RFC PATCH v2 07/41] arm64/sve: Allow kernel-mode NEON to be disabled
 in Kconfig
In-Reply-To: <1490194274-30569-1-git-send-email-Dave.Martin@arm.com>
References: <1490194274-30569-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1490194274-30569-8-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, support for kernel-mode NEON alongside the Scalable
Vector Extension doesn't work, so allow KERNEL_MODE_NEON to be
disabled.

This is only needed for bisectability of the SVE patches and will
be removed later.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/Kconfig | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 6f270a8..cf82776 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -226,9 +226,6 @@ config SWIOTLB
 config IOMMU_HELPER
 	def_bool SWIOTLB
 
-config KERNEL_MODE_NEON
-	def_bool y
-
 config FIX_EARLYCON_MEM
 	def_bool y
 
@@ -274,6 +271,10 @@ endmenu
 
 menu "Kernel Features"
 
+config KERNEL_MODE_NEON
+	bool "Support NEON/FPSIMD code in the kernel"
+	default y
+
 menu "ARM errata workarounds via the alternatives framework"
 
 config ARM64_ERRATUM_826319
-- 
2.1.4

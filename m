From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 19 Dec 2012 17:54:42 +0000
Subject: [PATCH v2 3/7] arm64: Always select ARM_AMBA and GENERIC_GPIO
In-Reply-To: <1355939686-23728-1-git-send-email-catalin.marinas@arm.com>
References: <1355939686-23728-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <1355939686-23728-4-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Needed for most SoCs.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index b310a71..131c749 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2,6 +2,7 @@ config ARM64
 	def_bool y
 	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
 	select ARCH_WANT_COMPAT_IPC_PARSE_VERSION
+	select ARM_AMBA
 	select CLONE_BACKWARDS
 	select COMMON_CLK
 	select GENERIC_CLOCKEVENTS
@@ -92,6 +93,9 @@ config SWIOTLB
 config IOMMU_HELPER
 	def_bool SWIOTLB
 
+config GENERIC_GPIO
+	def_bool y
+
 source "init/Kconfig"
 
 source "kernel/Kconfig.freezer"

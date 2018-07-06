From: nkela@cisco.com (Nikunj Kela)
Date: Fri,  6 Jul 2018 08:56:27 -0700
Subject: [PATCH] arm64: add ARM64-specific support for flatmem
Message-ID: <20180706155627.23937-1-nkela@cisco.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: xe-kernel at external.cisco.com
Cc: Nikunj Kela <nkela@cisco.com>
Signed-off-by: Nikunj Kela <nkela@cisco.com>
---
 arch/arm64/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 42c090c..5e791f0 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -775,6 +775,10 @@ config ARCH_SPARSEMEM_DEFAULT
 config ARCH_SELECT_MEMORY_MODEL
 	def_bool ARCH_SPARSEMEM_ENABLE
 
+config ARCH_FLATMEM_ENABLE
+	def_bool y
+	depends on ARM64 && !NUMA
+
 config HAVE_ARCH_PFN_VALID
 	def_bool ARCH_HAS_HOLES_MEMORYMODEL || !SPARSEMEM
 
-- 
2.10.3.dirty

From: hejianet@gmail.com (Jia He)
Date: Wed, 11 Apr 2018 00:21:52 -0700
Subject: [PATCH v8 1/6] arm: arm64: introduce CONFIG_HAVE_MEMBLOCK_PFN_VALID
In-Reply-To: <1523431317-30612-1-git-send-email-hejianet@gmail.com>
References: <1523431317-30612-1-git-send-email-hejianet@gmail.com>
Message-ID: <1523431317-30612-2-git-send-email-hejianet@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make CONFIG_HAVE_MEMBLOCK_PFN_VALID a config option so it can move
memblock_next_valid_pfn to generic code file.

arm/arm64 can benefit from this booting time improvement.

Signed-off-by: Jia He <jia.he@hxt-semitech.com>
---
 arch/arm/Kconfig   | 4 ++++
 arch/arm64/Kconfig | 4 ++++
 mm/Kconfig         | 3 +++
 3 files changed, 11 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 51c8df5..77bc1bb 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1637,6 +1637,10 @@ config ARCH_SELECT_MEMORY_MODEL
 config HAVE_ARCH_PFN_VALID
 	def_bool ARCH_HAS_HOLES_MEMORYMODEL || !SPARSEMEM
 
+config HAVE_MEMBLOCK_PFN_VALID
+	def_bool y
+	depends on HAVE_ARCH_PFN_VALID
+
 config HAVE_GENERIC_GUP
 	def_bool y
 	depends on ARM_LPAE
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index c9a7e9e..f374203 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -747,6 +747,10 @@ config ARCH_SELECT_MEMORY_MODEL
 config HAVE_ARCH_PFN_VALID
 	def_bool ARCH_HAS_HOLES_MEMORYMODEL || !SPARSEMEM
 
+config HAVE_MEMBLOCK_PFN_VALID
+	def_bool y
+	depends on HAVE_ARCH_PFN_VALID
+
 config HW_PERF_EVENTS
 	def_bool y
 	depends on ARM_PMU
diff --git a/mm/Kconfig b/mm/Kconfig
index c782e8f..c53ac38 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -137,6 +137,9 @@ config HAVE_MEMBLOCK_NODE_MAP
 config HAVE_MEMBLOCK_PHYS_MAP
 	bool
 
+config HAVE_MEMBLOCK_PFN_VALID
+	bool
+
 config HAVE_GENERIC_GUP
 	bool
 
-- 
2.7.4

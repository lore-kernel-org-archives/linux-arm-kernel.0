From: hejianet@gmail.com (Jia He)
Date: Wed, 22 Aug 2018 11:07:15 +0800
Subject: [PATCH v11 1/3] arm: arm64: introduce CONFIG_HAVE_MEMBLOCK_PFN_VALID
In-Reply-To: <1534907237-2982-1-git-send-email-jia.he@hxt-semitech.com>
References: <1534907237-2982-1-git-send-email-jia.he@hxt-semitech.com>
Message-ID: <1534907237-2982-2-git-send-email-jia.he@hxt-semitech.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make CONFIG_HAVE_MEMBLOCK_PFN_VALID a new config option so it can move
memblock_next_valid_pfn to generic code file. All the latter optimizations
are based on this config.

The memblock initialization time on arm/arm64 can benefit from this.

Signed-off-by: Jia He <jia.he@hxt-semitech.com>
Reviewed-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 arch/arm/Kconfig   | 1 +
 arch/arm64/Kconfig | 1 +
 mm/Kconfig         | 3 +++
 3 files changed, 5 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 843edfd..d3c7705 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1641,6 +1641,7 @@ config ARCH_SELECT_MEMORY_MODEL
 
 config HAVE_ARCH_PFN_VALID
 	def_bool ARCH_HAS_HOLES_MEMORYMODEL || !SPARSEMEM
+	select HAVE_MEMBLOCK_PFN_VALID
 
 config HAVE_GENERIC_GUP
 	def_bool y
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 42c090c..d4119e6 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -777,6 +777,7 @@ config ARCH_SELECT_MEMORY_MODEL
 
 config HAVE_ARCH_PFN_VALID
 	def_bool ARCH_HAS_HOLES_MEMORYMODEL || !SPARSEMEM
+	select HAVE_MEMBLOCK_PFN_VALID
 
 config HW_PERF_EVENTS
 	def_bool y
diff --git a/mm/Kconfig b/mm/Kconfig
index 94af022..28fcf54 100644
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
1.8.3.1

From: bill4carson@gmail.com (bill4carson at gmail.com)
Date: Mon, 30 Jan 2012 15:57:17 +0800
Subject: [PATCH 6/7] Add hugetlb Kconfig option
In-Reply-To: <1327910238-18704-1-git-send-email-bill4carson@gmail.com>
References: <1327910238-18704-1-git-send-email-bill4carson@gmail.com>
Message-ID: <1327910238-18704-7-git-send-email-bill4carson@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bill Carson <bill4carson@gmail.com>

Signed-off-by: Bill Carson <bill4carson@gmail.com>
---
 arch/arm/Kconfig |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a48aecc..161bca6 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -985,6 +985,35 @@ config ARCH_ZYNQ
 	  Support for Xilinx Zynq ARM Cortex A9 Platform
 endchoice
 
+config SYS_SUPPORTS_HUGETLBFS
+		def_bool n
+
+config ARM_HUGETLB_SUPPORT
+	bool "Support HUGETLB for ARMv7 (EXPERIMENTAL)"
+	depends on CPU_V7 && EXPERIMENTAL
+	select SYS_SUPPORTS_HUGETLBFS
+	select HUGETLBFS
+	default y
+
+choice
+	prompt "Huge Page Size"
+	depends on ARM_HUGETLB_SUPPORT
+	default HUGEPAGE_SIZE_2MB
+
+config HUGEPAGE_SIZE_2MB
+	bool "2MB"
+	depends on ARM_HUGETLB_SUPPORT
+	help
+	 This option select huge page size in 2MB units
+
+config HUGEPAGE_SIZE_16MB
+	bool "16MB"
+	depends on ARM_HUGETLB_SUPPORT
+	help
+	  This option select huge page size in 16MB units
+
+endchoice
+
 #
 # This is sorted alphabetically by mach-* pathname.  However, plat-*
 # Kconfigs may be included either alphabetically (according to the
-- 
1.7.1

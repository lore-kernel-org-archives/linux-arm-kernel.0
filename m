From: zhongjiang@huawei.com (zhongjiang)
Date: Sat, 10 Dec 2016 19:29:46 +0800
Subject: [RFC PATCH] arm64: make WANT_HUGE_PMD_SHARE depends on HUGETLB_PAGE
Message-ID: <1481369386-9529-1-git-send-email-zhongjiang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: zhong jiang <zhongjiang@huawei.com>

when HUGETLB_PAGE is disable, WANT_HUGE_PMD_SHARE contains the
fuctions should not be use. therefore, we add the dependency.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 969ef88..694ca73 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -640,6 +640,7 @@ config SYS_SUPPORTS_HUGETLBFS
 
 config ARCH_WANT_HUGE_PMD_SHARE
 	def_bool y if ARM64_4K_PAGES || (ARM64_16K_PAGES && !ARM64_VA_BITS_36)
+	depends on HUGETLB_PAGE
 
 config ARCH_HAS_CACHE_LINE_SIZE
 	def_bool y
-- 
1.8.3.1

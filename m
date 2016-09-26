From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Mon, 26 Sep 2016 15:36:50 +0800
Subject: [PATCH -next] arm64: Kconfig: select OF/ACPI_NUMA under NUMA config
Message-ID: <1474875410-23016-1-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move OF_NUMA select under NUMA config, and select ACPI_NUMA
when ACPI enabled.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/arm64/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 3b4afbc..6ee8ceb 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -100,7 +100,6 @@ config ARM64
 	select NO_BOOTMEM
 	select OF
 	select OF_EARLY_FLATTREE
-	select OF_NUMA if NUMA && OF
 	select OF_RESERVED_MEM
 	select PCI_ECAM if ACPI
 	select POWER_RESET
@@ -578,6 +577,8 @@ config HOTPLUG_CPU
 config NUMA
 	bool "Numa Memory Allocation and Scheduler Support"
 	depends on SMP
+	select ACPI_NUMA if ACPI
+	select OF_NUMA
 	help
 	  Enable NUMA (Non Uniform Memory Access) support.
 
-- 
1.7.12.4

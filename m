From: kim.phillips@arm.com (Kim Phillips)
Date: Tue, 30 Aug 2016 14:08:39 -0500
Subject: [PATCH 2/2] arm64: don't select PERF_USE_VMALLOC by default
Message-ID: <20160830140839.75e0689719bf884c9e38e5e4@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Any arm64 based parts that have cache aliasing issues can set it
manually.  Apparently dragged in from ARM(32) defaults in commit
8c2c3df "arm64: Build infrastructure".

Signed-off-by: Kim Phillips <kim.phillips@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index bc3f00f..2e6874f 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -105,7 +105,6 @@ config ARM64
 	select OF_NUMA if NUMA && OF
 	select OF_RESERVED_MEM
 	select PCI_ECAM if ACPI
-	select PERF_USE_VMALLOC
 	select POWER_RESET
 	select POWER_SUPPLY
 	select SPARSE_IRQ
-- 
2.9.3

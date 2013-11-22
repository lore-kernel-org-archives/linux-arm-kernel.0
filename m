From: robherring2@gmail.com (Rob Herring)
Date: Fri, 22 Nov 2013 15:07:31 -0600
Subject: [PATCH] arm64: make default NR_CPUS 8
Message-ID: <1385154451-2476-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Rather than continue to add per platform defaults, make the default a
likely common core count. 8 is also the default for x86.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 109687a..bff461d 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -160,8 +160,7 @@ config NR_CPUS
 	range 2 32
 	depends on SMP
 	# These have to remain sorted largest to smallest
-	default "8" if ARCH_XGENE
-	default "4"
+	default "8"
 
 config HOTPLUG_CPU
 	bool "Support for hot-pluggable CPUs"
-- 
1.8.1.2

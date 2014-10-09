From: riku.voipio@linaro.org (Riku Voipio)
Date: Thu,  9 Oct 2014 13:54:59 +0300
Subject: [PATCH] gcov: add ARM64 to GCOV_PROFILE_ALL
Message-ID: <1412852099-23099-1-git-send-email-riku.voipio@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Following up the arm testing of gcov, turns out gcov on ARM64
works fine as well. Only change needed is adding ARM64 to Kconfig
depends.

Tested with qemu and mach-virt

Signed-off-by: Riku Voipio <riku.voipio@linaro.org>
---
 kernel/gcov/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/gcov/Kconfig b/kernel/gcov/Kconfig
index cf66c5c..3b74087 100644
--- a/kernel/gcov/Kconfig
+++ b/kernel/gcov/Kconfig
@@ -35,7 +35,7 @@ config GCOV_KERNEL
 config GCOV_PROFILE_ALL
 	bool "Profile entire Kernel"
 	depends on GCOV_KERNEL
-	depends on SUPERH || S390 || X86 || PPC || MICROBLAZE || ARM
+	depends on SUPERH || S390 || X86 || PPC || MICROBLAZE || ARM || ARM64
 	default n
 	---help---
 	This options activates profiling for the entire kernel.
-- 
2.0.1

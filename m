From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Thu, 26 Jan 2017 11:19:55 +0800
Subject: [PATCH] arm64: Kconfig: select COMPAT_BINFMT_ELF only when BINFMT_ELF
 is set
Message-ID: <1485400795-51078-1-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix warning:
"(COMPAT) selects COMPAT_BINFMT_ELF which has unmet direct dependencies
(COMPAT && BINFMT_ELF)"

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/arm64/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1117421..4428673 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1010,7 +1010,7 @@ source "fs/Kconfig.binfmt"
 config COMPAT
 	bool "Kernel support for 32-bit EL0"
 	depends on ARM64_4K_PAGES || EXPERT
-	select COMPAT_BINFMT_ELF
+	select COMPAT_BINFMT_ELF if BINFMT_ELF
 	select HAVE_UID16
 	select OLD_SIGSUSPEND3
 	select COMPAT_OLD_SIGACTION
-- 
1.7.12.4

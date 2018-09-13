From: andrew.murray@arm.com (Andrew Murray)
Date: Thu, 13 Sep 2018 12:56:40 +0100
Subject: [PATCH] arm64: Remove unused VGA console support
Message-ID: <1536839800-14918-1-git-send-email-andrew.murray@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support for VGA_CONSOLE is not allowable due to commit ee23794b8668
("video: vgacon: Don't build on arm64"), thus remove the associated
unused code.

Whilst PCI on arm64 would support VGA a valid screen_info structure
is missing.

Signed-off-by: Andrew Murray <andrew.murray@arm.com>
---
 arch/arm64/kernel/setup.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 5b4fac4..95670a1 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -351,12 +351,8 @@ void __init setup_arch(char **cmdline_p)
 #endif
 
 #ifdef CONFIG_VT
-#if defined(CONFIG_VGA_CONSOLE)
-	conswitchp = &vga_con;
-#elif defined(CONFIG_DUMMY_CONSOLE)
 	conswitchp = &dummy_con;
 #endif
-#endif
 	if (boot_args[1] || boot_args[2] || boot_args[3]) {
 		pr_err("WARNING: x1-x3 nonzero in violation of boot protocol:\n"
 			"\tx1: %016llx\n\tx2: %016llx\n\tx3: %016llx\n"
-- 
2.7.4

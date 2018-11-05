From: zhangkehong@hisilicon.com (Kehong Zhang)
Date: Mon, 5 Nov 2018 20:33:31 +0800
Subject: [RFC] arm64: Kconfig: Choose ARM64_64K_PAGES as default
Message-ID: <1541421211-17561-1-git-send-email-zhangkehong@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For arm64 performance considerations, change default page size to 64K.

Cc: Catalin Marinas <catalin.marinas@arm.com>;
Cc: Will Deacon <will.deacon@arm.com>;
Signed-off-by: Kehong Zhang <zhangkehong@hisilicon.com>
---
 arch/arm64/Kconfig | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 787d785..56f651f 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -620,7 +620,7 @@ endmenu
 
 choice
 	prompt "Page size"
-	default ARM64_4K_PAGES
+	default ARM64_64K_PAGES
 	help
 	  Page size (translation granule) configuration.
 
@@ -639,10 +639,10 @@ config ARM64_16K_PAGES
 config ARM64_64K_PAGES
 	bool "64KB"
 	help
-	  This feature enables 64KB pages support (4KB by default)
-	  allowing only two levels of page tables and faster TLB
-	  look-up. AArch32 emulation requires applications compiled
-	  with 64K aligned segments.
+	  This feature enables 64KB pages support allowing only two
+	  levels of page tables and faster TLB look-up. AArch32
+	  emulation requires applications compiled with 64K aligned
+	  segments.
 
 endchoice
 
-- 
2.7.4

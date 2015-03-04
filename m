From: mark.rutland@arm.com (Mark Rutland)
Date: Wed,  4 Mar 2015 13:27:34 +0000
Subject: [PATCH 1/2] arm64: fixmap: make FIX_TEXT_POKE0 permanent
Message-ID: <1425475655-22118-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The FIX_TEST_POKE0 is currently at the end of the temporary fixmap
slots, despite the fact that it can be used at any point during runtime
(e.g. for poking the text of loaded modules), and thus should be a
permanent fixmap slot (as is the case on arm and x86).

This patch moves FIX_TEXT_POKE0 into the set of permanent fixmap slots.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Laura Abbott <lauraa@codeaurora.org>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/fixmap.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/fixmap.h b/arch/arm64/include/asm/fixmap.h
index defa0ff9..9264956 100644
--- a/arch/arm64/include/asm/fixmap.h
+++ b/arch/arm64/include/asm/fixmap.h
@@ -33,6 +33,7 @@
 enum fixed_addresses {
 	FIX_HOLE,
 	FIX_EARLYCON_MEM_BASE,
+	FIX_TEXT_POKE0,
 	__end_of_permanent_fixed_addresses,
 
 	/*
@@ -49,7 +50,6 @@ enum fixed_addresses {
 
 	FIX_BTMAP_END = __end_of_permanent_fixed_addresses,
 	FIX_BTMAP_BEGIN = FIX_BTMAP_END + TOTAL_FIX_BTMAPS - 1,
-	FIX_TEXT_POKE0,
 	__end_of_fixed_addresses
 };
 
-- 
1.9.1

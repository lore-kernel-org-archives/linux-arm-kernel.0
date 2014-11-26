From: lauraa@codeaurora.org (Laura Abbott)
Date: Tue, 25 Nov 2014 16:14:16 -0800
Subject: [PATCH] arm64: Add FIX_HOLE to permanent fixed addresses
Message-ID: <1416960856-2944-1-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Every other architecture with permanent fixed addresses has
FIX_HOLE as the first entry. This seems to be designed as a
debugging aid but there are a couple of side effects of not
having FIX_HOLE:

- If the first fixed address is 0, fix_to_virt -> virt_to_fix
triggers a BUG_ON for the virtual address being equal to
FIXADDR_TOP
- fix_to_virt may return a value outside of FIXADDR_START
and FIXADDR_TOP which may look like a bug to a developer.

Match up with other architectures and make everything clearer
by adding FIX_HOLE.

Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
---
 arch/arm64/include/asm/fixmap.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/include/asm/fixmap.h b/arch/arm64/include/asm/fixmap.h
index 5f7bfe6..424a10f 100644
--- a/arch/arm64/include/asm/fixmap.h
+++ b/arch/arm64/include/asm/fixmap.h
@@ -31,6 +31,7 @@
  *
  */
 enum fixed_addresses {
+	FIX_HOLE,
 	FIX_EARLYCON_MEM_BASE,
 	__end_of_permanent_fixed_addresses,
 
-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project

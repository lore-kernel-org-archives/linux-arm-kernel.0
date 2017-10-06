From: ben@decadent.org.uk (Ben Hutchings)
Date: Fri, 6 Oct 2017 03:00:01 +0100
Subject: [PATCH] arm64: elf.h: Correct comment about READ_IMPLIES_EXEC
 propagation
Message-ID: <20171006020001.GD2971@decadent.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Process personality always propagates across a fork(), but can change
at an execve().

Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/arm64/include/asm/elf.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index 33be513ef24c..fac1c4de7898 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -188,8 +188,8 @@ typedef compat_elf_greg_t		compat_elf_gregset_t[COMPAT_ELF_NGREG];
 
 #define compat_start_thread		compat_start_thread
 /*
- * Unlike the native SET_PERSONALITY macro, the compat version inherits
- * READ_IMPLIES_EXEC across a fork() since this is the behaviour on
+ * Unlike the native SET_PERSONALITY macro, the compat version maintains
+ * READ_IMPLIES_EXEC across an execve() since this is the behaviour on
  * arch/arm/.
  */
 #define COMPAT_SET_PERSONALITY(ex)					\
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 811 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171006/041ef202/attachment.sig>

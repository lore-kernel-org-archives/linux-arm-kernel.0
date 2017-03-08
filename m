From: Dave.Martin@arm.com (Dave Martin)
Date: Wed,  8 Mar 2017 12:31:04 +0000
Subject: [PATCH v2] arm64/sve: ELF: Reserve ELF note number for SVE
Message-ID: <1488976264-1274-1-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the ELF note assignment that will be required for supporting
the Scalable Vector Extension is well understood, it makes sense to
reserve the relevant number now in order to help other projects
coordinate.

This patch documents reservation for the expcted assignment.

Later patches implementing SVE support will replace this
reservation with the appropriate #define.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 include/uapi/linux/elf.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
index b59ee07..9f59598 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -414,6 +414,7 @@ typedef struct elf64_shdr {
 #define NT_ARM_HW_BREAK	0x402		/* ARM hardware breakpoint registers */
 #define NT_ARM_HW_WATCH	0x403		/* ARM hardware watchpoint registers */
 #define NT_ARM_SYSTEM_CALL	0x404	/* ARM system call number */
+					/* 0x405 reserved for ARM SVE */
 #define NT_METAG_CBUF	0x500		/* Metag catch buffer registers */
 #define NT_METAG_RPIPE	0x501		/* Metag read pipeline state */
 #define NT_METAG_TLS	0x502		/* Metag TLS pointer */
-- 
2.1.4

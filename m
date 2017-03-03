From: Dave.Martin@arm.com (Dave Martin)
Date: Fri,  3 Mar 2017 14:13:26 +0000
Subject: [PATCH] arm64/sve: Reserve HWCAP and ELF note numbers for SVE
Message-ID: <1488550406-11204-1-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the HWCAP and ELF note assignments that will be required for
supporting the Scalable Vector Extension are well understood, it
makes sense to reserve the relevant numbers now in order to help
other projects coordinate.

This patch documents reservations for the expcted assignments.

Later patches implementing SVE support will replace these
reservations with the appropriate #defines.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---

The most recent full RFC series for SVE is here:
http://lists.infradead.org/pipermail/linux-arm-kernel/2016-November/470507.html

 arch/arm64/include/uapi/asm/hwcap.h | 1 +
 include/uapi/linux/elf.h            | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm64/include/uapi/asm/hwcap.h b/arch/arm64/include/uapi/asm/hwcap.h
index a739287..fb75a34 100644
--- a/arch/arm64/include/uapi/asm/hwcap.h
+++ b/arch/arm64/include/uapi/asm/hwcap.h
@@ -30,5 +30,6 @@
 #define HWCAP_ATOMICS		(1 << 8)
 #define HWCAP_FPHP		(1 << 9)
 #define HWCAP_ASIMDHP		(1 << 10)
+				/* (1 << 11) reserved for SVE */
 
 #endif /* _UAPI__ASM_HWCAP_H */
diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
index b59ee07..b22d215 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -414,6 +414,7 @@ typedef struct elf64_shdr {
 #define NT_ARM_HW_BREAK	0x402		/* ARM hardware breakpoint registers */
 #define NT_ARM_HW_WATCH	0x403		/* ARM hardware watchpoint registers */
 #define NT_ARM_SYSTEM_CALL	0x404	/* ARM system call number */
+					/* 0x405 reserved for SVE */
 #define NT_METAG_CBUF	0x500		/* Metag catch buffer registers */
 #define NT_METAG_RPIPE	0x501		/* Metag read pipeline state */
 #define NT_METAG_TLS	0x502		/* Metag TLS pointer */
-- 
2.1.4

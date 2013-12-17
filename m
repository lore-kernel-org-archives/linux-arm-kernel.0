From: will.deacon@arm.com (Will Deacon)
Date: Tue, 17 Dec 2013 12:20:05 +0000
Subject: [PATCH 2/4] arm64: futex: ensure .fixup entries are sufficiently
 aligned
In-Reply-To: <1387282807-6024-1-git-send-email-will.deacon@arm.com>
References: <1387282807-6024-1-git-send-email-will.deacon@arm.com>
Message-ID: <1387282807-6024-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

AArch64 instructions must be 4-byte aligned, so make sure this is true
for the futex .fixup section.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/futex.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/include/asm/futex.h b/arch/arm64/include/asm/futex.h
index c582fa316366..78cc3aba5d69 100644
--- a/arch/arm64/include/asm/futex.h
+++ b/arch/arm64/include/asm/futex.h
@@ -30,6 +30,7 @@
 "	cbnz	%w3, 1b\n"						\
 "3:\n"									\
 "	.pushsection .fixup,\"ax\"\n"					\
+"	.align	2\n"							\
 "4:	mov	%w0, %w5\n"						\
 "	b	3b\n"							\
 "	.popsection\n"							\
-- 
1.8.2.2

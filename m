From: mathieu.desnoyers@efficios.com (Mathieu Desnoyers)
Date: Thu, 18 Mar 2010 10:07:45 -0400
Subject: [PATCH] arm 32v6k fix comment 2-byte cmpxchg
Message-ID: <20100318140745.GA718@Krystal>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit ecd322c9b3e4ac70f9f108badde3eb6b99c7993d introduced a 2-byte cmpxchg with
an incorrect assembly comment (labeled __cmpxchg1).

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: Catalin Marinas <catalin.marinas@arm.com>
CC: Nicolas Pitre <nico@cam.org>
CC: Russell King <rmk+kernel@arm.linux.org.uk>
CC: Alexander Shishkin <virtuoso@slind.org>
---
 arch/arm/include/asm/system.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6-lttng/arch/arm/include/asm/system.h
===================================================================
--- linux-2.6-lttng.orig/arch/arm/include/asm/system.h	2010-03-18 09:43:40.000000000 -0400
+++ linux-2.6-lttng/arch/arm/include/asm/system.h	2010-03-18 09:44:19.000000000 -0400
@@ -372,7 +372,7 @@ static inline unsigned long __cmpxchg(vo
 		break;
 	case 2:
 		do {
-			asm volatile("@ __cmpxchg1\n"
+			asm volatile("@ __cmpxchg2\n"
 			"	ldrexh	%1, [%2]\n"
 			"	mov	%0, #0\n"
 			"	teq	%1, %3\n"

-- 
Mathieu Desnoyers
Operating System Efficiency Consultant
EfficiOS Inc.
http://www.efficios.com

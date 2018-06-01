From: mark.rutland@arm.com (Mark Rutland)
Date: Fri,  1 Jun 2018 12:24:37 +0100
Subject: [PATCHv2 15/19] arm64: remove in-kernel call to sys_personality()
In-Reply-To: <20180601112441.37810-1-mark.rutland@arm.com>
References: <20180601112441.37810-1-mark.rutland@arm.com>
Message-ID: <20180601112441.37810-16-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With pt_regs syscall wrappers, the calling convention for
sys_personality() will change. Use ksys_personality(), which is
functionally equivalent.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/sys.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/sys.c b/arch/arm64/kernel/sys.c
index 31045f3fed92..a82c3f7a9a90 100644
--- a/arch/arm64/kernel/sys.c
+++ b/arch/arm64/kernel/sys.c
@@ -42,7 +42,7 @@ SYSCALL_DEFINE1(arm64_personality, unsigned int, personality)
 	if (personality(personality) == PER_LINUX32 &&
 		!system_supports_32bit_el0())
 		return -EINVAL;
-	return sys_personality(personality);
+	return ksys_personality(personality);
 }
 
 /*
-- 
2.11.0

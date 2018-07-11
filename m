From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 11 Jul 2018 14:56:52 +0100
Subject: [PATCHv5 17/21] arm64: remove in-kernel call to sys_personality()
In-Reply-To: <20180711135656.20670-1-mark.rutland@arm.com>
References: <20180711135656.20670-1-mark.rutland@arm.com>
Message-ID: <20180711135656.20670-18-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With pt_regs syscall wrappers, the calling convention for
sys_personality() will change. Use ksys_personality(), which is
functionally equivalent.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/sys.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/sys.c b/arch/arm64/kernel/sys.c
index df8180175515..f4e02f6aceb8 100644
--- a/arch/arm64/kernel/sys.c
+++ b/arch/arm64/kernel/sys.c
@@ -44,7 +44,7 @@ SYSCALL_DEFINE1(arm64_personality, unsigned int, personality)
 	if (personality(personality) == PER_LINUX32 &&
 		!system_supports_32bit_el0())
 		return -EINVAL;
-	return sys_personality(personality);
+	return ksys_personality(personality);
 }
 
 /*
-- 
2.11.0

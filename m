From: will.deacon@arm.com (Will Deacon)
Date: Thu, 19 Oct 2017 16:55:34 +0100
Subject: [PATCH 4/4] arm64: uapi: Remove PSR_Q_BIT
In-Reply-To: <1508428534-20694-1-git-send-email-will.deacon@arm.com>
References: <1508428534-20694-1-git-send-email-will.deacon@arm.com>
Message-ID: <1508428534-20694-5-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PSTATE.Q only exists for AArch32, which can be referred to using
COMPAT_PSR_Q_BIT. Remove PSR_Q_BIT, since the native bit doesn't exist
in the architecture

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/uapi/asm/ptrace.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/include/uapi/asm/ptrace.h b/arch/arm64/include/uapi/asm/ptrace.h
index d1ff83dfe5de..3697d95ba0a1 100644
--- a/arch/arm64/include/uapi/asm/ptrace.h
+++ b/arch/arm64/include/uapi/asm/ptrace.h
@@ -46,7 +46,6 @@
 #define PSR_D_BIT	0x00000200
 #define PSR_PAN_BIT	0x00400000
 #define PSR_UAO_BIT	0x00800000
-#define PSR_Q_BIT	0x08000000
 #define PSR_V_BIT	0x10000000
 #define PSR_C_BIT	0x20000000
 #define PSR_Z_BIT	0x40000000
-- 
2.1.4

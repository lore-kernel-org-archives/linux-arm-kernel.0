From: gang.chen@asianux.com (Chen Gang)
Date: Tue, 08 Oct 2013 18:59:15 +0800
Subject: [PATCH v2 2/2] ARM: include: asm: use 'int' instead of 'unsigned
 long' for 'oldval' in atomic_cmpxchg().
In-Reply-To: <5253E533.4070803@asianux.com>
References: <20131002104158.GD28311@mudshark.cambridge.arm.com>
 <524C3981.20307@asianux.com> <524D416B.5090709@asianux.com>
 <20131003163200.GE7408@mudshark.cambridge.arm.com>
 <524E8FBC.2080200@asianux.com>
 <20131004153742.GR24303@mudshark.cambridge.arm.com>
 <20131004154208.GS24303@mudshark.cambridge.arm.com>
 <524F5566.4010204@asianux.com> <524F594B.1070106@asianux.com>
 <525385A4.5050200@asianux.com>
 <20131008103455.GF17148@mudshark.cambridge.arm.com>
 <5253E4F3.4090205@asianux.com> <5253E533.4070803@asianux.com>
Message-ID: <5253E583.5020805@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For atomic_cmpxchg(), the type of 'oldval' need be 'int' to match the
type of "*ptr" (used by 'ldrex' instruction) and 'old' (used by 'teq'
instruction).

Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/arm/include/asm/atomic.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/include/asm/atomic.h b/arch/arm/include/asm/atomic.h
index a715ac0..9ee7e01 100644
--- a/arch/arm/include/asm/atomic.h
+++ b/arch/arm/include/asm/atomic.h
@@ -114,7 +114,8 @@ static inline int atomic_sub_return(int i, atomic_t *v)
 
 static inline int atomic_cmpxchg(atomic_t *ptr, int old, int new)
 {
-	unsigned long oldval, res;
+	int oldval;
+	unsigned long res;
 
 	smp_mb();
 
-- 
1.7.7.6

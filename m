From: gang.chen@asianux.com (Chen Gang)
Date: Thu, 10 Oct 2013 10:31:22 +0800
Subject: [PATCH 1/3] s390: include: asm: atomic.h: use 'unsigned int' instead
 of 'unsigned long' for atomic_*_mask()
In-Reply-To: <52561137.3070608@asianux.com>
References: <52561137.3070608@asianux.com>
Message-ID: <5256117A.4000009@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The type of 'v->counter' is always 'int', and related inline assembly
code also process 'int', so use 'unsigned int' instead of 'unsigned
long' for the 'mask'.


Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/s390/include/asm/atomic.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/include/asm/atomic.h b/arch/s390/include/asm/atomic.h
index a62ed2d..12c5ec1 100644
--- a/arch/s390/include/asm/atomic.h
+++ b/arch/s390/include/asm/atomic.h
@@ -113,12 +113,12 @@ static inline void atomic_add(int i, atomic_t *v)
 #define atomic_dec_return(_v)		atomic_sub_return(1, _v)
 #define atomic_dec_and_test(_v)		(atomic_sub_return(1, _v) == 0)
 
-static inline void atomic_clear_mask(unsigned long mask, atomic_t *v)
+static inline void atomic_clear_mask(unsigned int mask, atomic_t *v)
 {
 	__ATOMIC_LOOP(v, ~mask, __ATOMIC_AND);
 }
 
-static inline void atomic_set_mask(unsigned long mask, atomic_t *v)
+static inline void atomic_set_mask(unsigned int mask, atomic_t *v)
 {
 	__ATOMIC_LOOP(v, mask, __ATOMIC_OR);
 }
-- 
1.7.7.6

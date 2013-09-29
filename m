From: gang.chen@asianux.com (Chen Gang)
Date: Sun, 29 Sep 2013 11:52:28 +0800
Subject: [PATCH 2/2] ARM: include: asm: use 'int' instead of 'unsigned long'
 for normal register variables within atomic.h
In-Reply-To: <5247A1FA.4030305@asianux.com>
References: <523D7DC7.8030603@asianux.com>
 <20130924093041.GB15119@mudshark.cambridge.arm.com>
 <5242498F.8060407@asianux.com>
 <20130925160746.GC14502@mudshark.cambridge.arm.com>
 <5243953E.6010405@asianux.com>
 <20130926100422.GE2855@mudshark.cambridge.arm.com>
 <5244148F.6080405@asianux.com>
 <20130927110618.GB9520@mudshark.cambridge.arm.com>
 <5247A1D1.6080505@asianux.com> <5247A1FA.4030305@asianux.com>
Message-ID: <5247A3FC.9020508@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"arc/arm" will be never on 64-bit, it is mainly on 32-bit (may also can
be on 16-bit).

So better to use 'int' instead of 'unsigned long' for normal register
variable (on 16-bit, 'int' is allowed to be 16-bit, so historically,
often use 'int' for normal register variables).


Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/arm/include/asm/atomic.h |   28 ++++++++++++++--------------
 1 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm/include/asm/atomic.h b/arch/arm/include/asm/atomic.h
index a715ac0..9f94ee7 100644
--- a/arch/arm/include/asm/atomic.h
+++ b/arch/arm/include/asm/atomic.h
@@ -38,7 +38,7 @@
  */
 static inline void atomic_add(int i, atomic_t *v)
 {
-	unsigned long tmp;
+	int tmp;
 	int result;

 	__asm__ __volatile__("@ atomic_add\n"
@@ -54,7 +54,7 @@ static inline void atomic_add(int i, atomic_t *v)

 static inline int atomic_add_return(int i, atomic_t *v)
 {
-	unsigned long tmp;
+	int tmp;
 	int result;

 	smp_mb();
@@ -76,7 +76,7 @@ static inline int atomic_add_return(int i, atomic_t *v)

 static inline void atomic_sub(int i, atomic_t *v)
 {
-	unsigned long tmp;
+	int tmp;
 	int result;

 	__asm__ __volatile__("@ atomic_sub\n"
@@ -92,7 +92,7 @@ static inline void atomic_sub(int i, atomic_t *v)

 static inline int atomic_sub_return(int i, atomic_t *v)
 {
-	unsigned long tmp;
+	int tmp;
 	int result;

 	smp_mb();
@@ -114,7 +114,7 @@ static inline int atomic_sub_return(int i, atomic_t *v)

 static inline int atomic_cmpxchg(atomic_t *ptr, int old, int new)
 {
-	unsigned long oldval, res;
+	int oldval, res;

 	smp_mb();

@@ -136,7 +136,7 @@ static inline int atomic_cmpxchg(atomic_t *ptr, int
old, int new)

 static inline void atomic_clear_mask(unsigned long mask, unsigned long
*addr)
 {
-	unsigned long tmp, tmp2;
+	int tmp, tmp2;

 	__asm__ __volatile__("@ atomic_clear_mask\n"
 "1:	ldrex	%0, [%3]\n"
@@ -297,7 +297,7 @@ static inline void atomic64_set(atomic64_t *v, long
long i)
 static inline void atomic64_add(long long i, atomic64_t *v)
 {
 	long long result;
-	unsigned long tmp;
+	int tmp;

 	__asm__ __volatile__("@ atomic64_add\n"
 "1:	ldrexd	%0, %H0, [%3]\n"
@@ -314,7 +314,7 @@ static inline void atomic64_add(long long i,
atomic64_t *v)
 static inline long long atomic64_add_return(long long i, atomic64_t *v)
 {
 	long long result;
-	unsigned long tmp;
+	int tmp;

 	smp_mb();

@@ -337,7 +337,7 @@ static inline long long atomic64_add_return(long
long i, atomic64_t *v)
 static inline void atomic64_sub(long long i, atomic64_t *v)
 {
 	long long result;
-	unsigned long tmp;
+	int tmp;

 	__asm__ __volatile__("@ atomic64_sub\n"
 "1:	ldrexd	%0, %H0, [%3]\n"
@@ -354,7 +354,7 @@ static inline void atomic64_sub(long long i,
atomic64_t *v)
 static inline long long atomic64_sub_return(long long i, atomic64_t *v)
 {
 	long long result;
-	unsigned long tmp;
+	int tmp;

 	smp_mb();

@@ -378,7 +378,7 @@ static inline long long atomic64_cmpxchg(atomic64_t
*ptr, long long old,
 					long long new)
 {
 	long long oldval;
-	unsigned long res;
+	int res;

 	smp_mb();

@@ -402,7 +402,7 @@ static inline long long atomic64_cmpxchg(atomic64_t
*ptr, long long old,
 static inline long long atomic64_xchg(atomic64_t *ptr, long long new)
 {
 	long long result;
-	unsigned long tmp;
+	int tmp;

 	smp_mb();

@@ -423,7 +423,7 @@ static inline long long atomic64_xchg(atomic64_t
*ptr, long long new)
 static inline long long atomic64_dec_if_positive(atomic64_t *v)
 {
 	long long result;
-	unsigned long tmp;
+	int tmp;

 	smp_mb();

@@ -449,7 +449,7 @@ static inline long long
atomic64_dec_if_positive(atomic64_t *v)
 static inline int atomic64_add_unless(atomic64_t *v, long long a, long
long u)
 {
 	long long val;
-	unsigned long tmp;
+	int tmp;
 	int ret = 1;

 	smp_mb();
-- 
1.7.7.6

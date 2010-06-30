From: will.deacon@arm.com (Will Deacon)
Date: Wed, 30 Jun 2010 15:04:48 +0100
Subject: [PATCH 4/4] ARM: atomic64_test: add ARM as supported architecture
In-Reply-To: <1277906688-12065-4-git-send-email-will.deacon@arm.com>
References: <1277906688-12065-1-git-send-email-will.deacon@arm.com>
	<1277906688-12065-2-git-send-email-will.deacon@arm.com>
	<1277906688-12065-3-git-send-email-will.deacon@arm.com>
	<1277906688-12065-4-git-send-email-will.deacon@arm.com>
Message-ID: <1277906688-12065-5-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM has support for the atomic64_dec_if_positive operation
so ensure that it is tested by the atomic64_test routine.

Cc: Nicolas Pitre <nico@fluxnic.net>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 lib/atomic64_test.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib/atomic64_test.c b/lib/atomic64_test.c
index 250ed11..44524cc 100644
--- a/lib/atomic64_test.c
+++ b/lib/atomic64_test.c
@@ -114,7 +114,7 @@ static __init int test_atomic64(void)
 	BUG_ON(v.counter != r);
 
 #if defined(CONFIG_X86) || defined(CONFIG_MIPS) || defined(CONFIG_PPC) || \
-    defined(CONFIG_S390) || defined(_ASM_GENERIC_ATOMIC64_H)
+    defined(CONFIG_S390) || defined(_ASM_GENERIC_ATOMIC64_H) || defined(CONFIG_ARM)
 	INIT(onestwos);
 	BUG_ON(atomic64_dec_if_positive(&v) != (onestwos - 1));
 	r -= one;
-- 
1.6.3.3

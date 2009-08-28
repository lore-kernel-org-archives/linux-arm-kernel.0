From: aaro.koskinen@nokia.com (Aaro Koskinen)
Date: Fri, 28 Aug 2009 14:58:15 +0300
Subject: [RFC] ARM: increase L1_CACHE_SHIFT
In-Reply-To: <>
References: <>
Message-ID: <1251460695-26481-1-git-send-email-aaro.koskinen@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

ARM Cortex-A8 has 64 byte cache line, so the current code is
wrong. This is little worrying if you e.g. read the comments from
eb5f4ca9536ba297c98721ecbbdf41ec5b987bd5.

What would be the proper way to handle this? Should we set it to 64
bytes for everyone, or set it according to some #define or Kconfig option?

---
 arch/arm/include/asm/cache.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/include/asm/cache.h b/arch/arm/include/asm/cache.h
index feaa75f..b786b24 100644
--- a/arch/arm/include/asm/cache.h
+++ b/arch/arm/include/asm/cache.h
@@ -4,7 +4,7 @@
 #ifndef __ASMARM_CACHE_H
 #define __ASMARM_CACHE_H
 
-#define L1_CACHE_SHIFT		5
+#define L1_CACHE_SHIFT		6
 #define L1_CACHE_BYTES		(1 << L1_CACHE_SHIFT)
 
 /*
-- 
1.5.4.3

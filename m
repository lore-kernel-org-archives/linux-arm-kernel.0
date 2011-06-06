From: will.deacon@arm.com (Will Deacon)
Date: Mon,  6 Jun 2011 17:55:47 +0100
Subject: [PATCH 03/11] ARM: hwcaps: use shifts instead of hardcoded constants
In-Reply-To: <1307379355-13802-1-git-send-email-will.deacon@arm.com>
References: <1307379355-13802-1-git-send-email-will.deacon@arm.com>
Message-ID: <1307379355-13802-4-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The HWCAP numbers are defined as constants, each one being a power of 2.
This has become slightly unwieldy now that we have reached 32k.

This patch changes the HWCAP defines to use (1 << n) instead of coding
the constant directly. The values remain unchanged.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/hwcap.h |   32 ++++++++++++++++----------------
 1 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm/include/asm/hwcap.h b/arch/arm/include/asm/hwcap.h
index c1062c3..81512db 100644
--- a/arch/arm/include/asm/hwcap.h
+++ b/arch/arm/include/asm/hwcap.h
@@ -4,22 +4,22 @@
 /*
  * HWCAP flags - for elf_hwcap (in kernel) and AT_HWCAP
  */
-#define HWCAP_SWP	1
-#define HWCAP_HALF	2
-#define HWCAP_THUMB	4
-#define HWCAP_26BIT	8	/* Play it safe */
-#define HWCAP_FAST_MULT	16
-#define HWCAP_FPA	32
-#define HWCAP_VFP	64
-#define HWCAP_EDSP	128
-#define HWCAP_JAVA	256
-#define HWCAP_IWMMXT	512
-#define HWCAP_CRUNCH	1024
-#define HWCAP_THUMBEE	2048
-#define HWCAP_NEON	4096
-#define HWCAP_VFPv3	8192
-#define HWCAP_VFPv3D16	16384
-#define HWCAP_TLS	32768
+#define HWCAP_SWP	(1 << 0)
+#define HWCAP_HALF	(1 << 1)
+#define HWCAP_THUMB	(1 << 2)
+#define HWCAP_26BIT	(1 << 3)	/* Play it safe */
+#define HWCAP_FAST_MULT	(1 << 4)
+#define HWCAP_FPA	(1 << 5)
+#define HWCAP_VFP	(1 << 6)
+#define HWCAP_EDSP	(1 << 7)
+#define HWCAP_JAVA	(1 << 8)
+#define HWCAP_IWMMXT	(1 << 9)
+#define HWCAP_CRUNCH	(1 << 10)
+#define HWCAP_THUMBEE	(1 << 11)
+#define HWCAP_NEON	(1 << 12)
+#define HWCAP_VFPv3	(1 << 13)
+#define HWCAP_VFPv3D16	(1 << 14)
+#define HWCAP_TLS	(1 << 15)
 
 #if defined(__KERNEL__) && !defined(__ASSEMBLY__)
 /*
-- 
1.7.0.4

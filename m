From: max@stro.at (maximilian attems)
Date: Tue, 17 May 2011 18:17:11 +0200
Subject: [PATCH] [klibc] arm: no usage of ARM_VALID_IMM() anymore
In-Reply-To: <1305649031-15622-1-git-send-email-max@stro.at>
References: <1305649031-15622-1-git-send-email-max@stro.at>
Message-ID: <1305649031-15622-2-git-send-email-max@stro.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since bd56c54ae409a2c36d23e61d4075e2d1ffcd1a23 aka klibc 1.4.1
the usage of that macro is gone, so just get rid of it.

Signed-off-by: maximilian attems <max@stro.at>
---
 usr/include/arch/arm/klibc/asmmacros.h |   20 --------------------
 1 files changed, 0 insertions(+), 20 deletions(-)

diff --git a/usr/include/arch/arm/klibc/asmmacros.h b/usr/include/arch/arm/klibc/asmmacros.h
index 8a21c94..b5bade2 100644
--- a/usr/include/arch/arm/klibc/asmmacros.h
+++ b/usr/include/arch/arm/klibc/asmmacros.h
@@ -7,24 +7,4 @@
 #ifndef _KLIBC_ASMMACROS_H
 #define _KLIBC_ASMMACROS_H
 
-/* An immediate in ARM can be any 8-bit value rotated by an even number of bits */
-
-#define ARM_VALID_IMM(x)	\
-	((((x) & ~0x000000ff) == 0) || \
-	 (((x) & ~0x000003fc) == 0) || \
-	 (((x) & ~0x00000ff0) == 0) || \
-	 (((x) & ~0x00003fc0) == 0) || \
-	 (((x) & ~0x0000ff00) == 0) || \
-	 (((x) & ~0x0003fc00) == 0) || \
-	 (((x) & ~0x000ff000) == 0) || \
-	 (((x) & ~0x003fc000) == 0) || \
-	 (((x) & ~0x00ff0000) == 0) || \
-	 (((x) & ~0x03fc0000) == 0) || \
-	 (((x) & ~0x0ff00000) == 0) || \
-	 (((x) & ~0x3fc00000) == 0) || \
-	 (((x) & ~0xff000000) == 0) || \
-	 (((x) & ~0xfc000003) == 0) || \
-	 (((x) & ~0xf000000f) == 0) || \
-	 (((x) & ~0xc000003f) == 0))
-
 #endif /* _KLIBC_ASMMACROS_H */
-- 
1.7.4.4

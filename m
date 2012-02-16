From: michael.opdenacker@free-electrons.com (Michael Opdenacker)
Date: Thu, 16 Feb 2012 15:54:16 +0100
Subject: [PATCH 1/2] ARM: remove memmove from boot/compressed/string.c
In-Reply-To: <1329404057-26346-1-git-send-email-michael.opdenacker@free-electrons.com>
References: <1329404057-26346-1-git-send-email-michael.opdenacker@free-electrons.com>
Message-ID: <1329404057-26346-2-git-send-email-michael.opdenacker@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes the memmove function from boot/compressed/string.c
- This definition conflicts with the one in lib/decompress_unxz.c
  This change is required to support xz compression on ARM.
- memmove is not used in any of the other decompressors
  in lib/decompress_*.c

Signed-off-by: Michael Opdenacker <michael.opdenacker@free-electrons.com>
---
 arch/arm/boot/compressed/string.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/compressed/string.c b/arch/arm/boot/compressed/string.c
index 36e53ef..369443a 100644
--- a/arch/arm/boot/compressed/string.c
+++ b/arch/arm/boot/compressed/string.c
@@ -40,6 +40,7 @@ void *memcpy(void *__dest, __const void *__src, size_t __n)
 	return __dest;
 }
 
+/*
 void *memmove(void *__dest, __const void *__src, size_t count)
 {
 	unsigned char *d = __dest;
@@ -55,6 +56,7 @@ void *memmove(void *__dest, __const void *__src, size_t count)
 		d[count] = s[count];
 	return __dest;
 }
+*/
 
 size_t strlen(const char *s)
 {
-- 
1.7.4.1

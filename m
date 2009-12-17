From: roel.kluin@gmail.com (Roel Kluin)
Date: Thu, 17 Dec 2009 22:15:58 +0100
Subject: [PATCH] ARM: Wrong size used in dump_mem()
Message-ID: <4B2A9F8E.5080508@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sizeof the pointed to should be used rather than of the pointer

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
Unless I am mistaken?

diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 3f361a7..5e828fa 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -102,7 +102,7 @@ static void dump_mem(const char *lvl, const char *str, unsigned long bottom,
 		unsigned long p;
 		char str[sizeof(" 12345678") * 8 + 1];
 
-		memset(str, ' ', sizeof(str));
+		memset(str, ' ', sizeof(*str));
 		str[sizeof(str) - 1] = '\0';
 
 		for (p = first, i = 0; i < 8 && p < top; i++, p += 4) {

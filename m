From: arjun024@gmail.com (Arjun Sreedharan)
Date: Sat, 22 Nov 2014 00:58:36 +0530
Subject: [PATCH] arm: early_printk: do bound check independent of @n
Message-ID: <1416598116-2461-1-git-send-email-arjun024@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Arjun Sreedharan <arjun024@gmail.com>
---
 arch/arm/kernel/early_printk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/early_printk.c b/arch/arm/kernel/early_printk.c
index 4307653..9e05f8a 100644
--- a/arch/arm/kernel/early_printk.c
+++ b/arch/arm/kernel/early_printk.c
@@ -16,7 +16,7 @@ extern void printch(int);
 
 static void early_write(const char *s, unsigned n)
 {
-	while (n-- > 0) {
+	while (*s && n-- > 0) {
 		if (*s == '\n')
 			printch('\r');
 		printch(*s);
-- 
1.7.11.7

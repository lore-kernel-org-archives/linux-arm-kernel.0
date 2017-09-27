From: alexander.sverdlin@nokia.com (Alexander Sverdlin)
Date: Wed, 27 Sep 2017 13:49:29 +0200
Subject: [PATCH 2/2] ARM: early_printk: Stop emitting double CR on the console
In-Reply-To: <20170927114929.9259-1-alexander.sverdlin@nokia.com>
References: <20170927114929.9259-1-alexander.sverdlin@nokia.com>
Message-ID: <20170927114929.9259-3-alexander.sverdlin@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

printch already takes care about LF->CRLF translation, so
early_write() just produced extra CR.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
---
 arch/arm/kernel/early_printk.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/kernel/early_printk.c b/arch/arm/kernel/early_printk.c
index 4307653..8300d5b 100644
--- a/arch/arm/kernel/early_printk.c
+++ b/arch/arm/kernel/early_printk.c
@@ -17,8 +17,6 @@ extern void printch(int);
 static void early_write(const char *s, unsigned n)
 {
 	while (n-- > 0) {
-		if (*s == '\n')
-			printch('\r');
 		printch(*s);
 		s++;
 	}
-- 
2.4.6

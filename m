From: p.wilczek@samsung.com (Piotr Wilczek)
Date: Wed, 18 Dec 2013 13:09:05 +0100
Subject: [PATCH V2 2/8] string: fix strncmp function
In-Reply-To: <1387368551-18958-1-git-send-email-p.wilczek@samsung.com>
References: <1386767259-15693-1-git-send-email-p.wilczek@samsung.com>
 <1387368551-18958-1-git-send-email-p.wilczek@samsung.com>
Message-ID: <1387368551-18958-3-git-send-email-p.wilczek@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now function returns the number of characters that differ in the compared strings.

Signed-off-by: Piotr Wilczek <p.wilczek@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
Changes for V2:
 - none

 string.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/string.c b/string.c
index d13e22b..ced25c8 100644
--- a/string.c
+++ b/string.c
@@ -24,7 +24,7 @@ int strncmp(const char *stra, const char *strb, int len)
 	const char *b = strb;
 
 	while ((a - stra) < len)
-		diff += *(a++) - *(b++);
+		diff += !!(*(a++) - *(b++));
 
 	return diff;
 }
-- 
1.7.9.5

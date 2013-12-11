From: p.wilczek@samsung.com (Piotr Wilczek)
Date: Wed, 11 Dec 2013 14:07:33 +0100
Subject: [PATCH 2/8] string: fix strncmp function
In-Reply-To: <1386767259-15693-1-git-send-email-p.wilczek@samsung.com>
References: <1386767259-15693-1-git-send-email-p.wilczek@samsung.com>
Message-ID: <1386767259-15693-3-git-send-email-p.wilczek@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix function to return the number of characters that differ in
the compared strings.

Signed-off-by: Piotr Wilczek <p.wilczek@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
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

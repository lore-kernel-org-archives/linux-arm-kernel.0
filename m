From: yefremov.denis@gmail.com (Denis Efremov)
Date: Thu,  9 May 2013 14:36:52 +0400
Subject: [PATCH 14/21] arm64: delay: remove inline marking of EXPORT_SYMBOL
 functions
In-Reply-To: <1368086241-9357-1-git-send-email-yefremov.denis@gmail.com>
References: <1368086241-9357-1-git-send-email-yefremov.denis@gmail.com>
Message-ID: <1368095819-11011-3-git-send-email-yefremov.denis@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

EXPORT_SYMBOL and inline directives are contradictory to each other.
The patch fixes this inconsistency.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Denis Efremov <yefremov.denis@gmail.com>
---
 arch/arm64/lib/delay.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/lib/delay.c b/arch/arm64/lib/delay.c
index dad4ec9..368ca15 100644
--- a/arch/arm64/lib/delay.c
+++ b/arch/arm64/lib/delay.c
@@ -33,7 +33,7 @@ void __delay(unsigned long cycles)
 }
 EXPORT_SYMBOL(__delay);
 
-inline void __const_udelay(unsigned long xloops)
+void __const_udelay(unsigned long xloops)
 {
 	unsigned long loops;
 
-- 
1.8.1.4

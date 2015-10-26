From: o.schinagl@ultimaker.com (Olliver Schinagl)
Date: Mon, 26 Oct 2015 22:32:35 +0100
Subject: [PATCH 04/10] pwm: core: use bitops
In-Reply-To: <1445895161-2317-1-git-send-email-o.schinagl@ultimaker.com>
References: <1445895161-2317-1-git-send-email-o.schinagl@ultimaker.com>
Message-ID: <1445895161-2317-5-git-send-email-o.schinagl@ultimaker.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Olliver Schinagl <oliver@schinagl.nl>

The pwm header defines bits manually while there is a nice bitops.h with
a BIT() macro. Use the BIT() macro to set bits in pwm.h

Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
---
 include/linux/pwm.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index d681f68..29315ad 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -1,6 +1,7 @@
 #ifndef __LINUX_PWM_H
 #define __LINUX_PWM_H
 
+#include <linux/bitops.h>
 #include <linux/err.h>
 #include <linux/of.h>
 
@@ -74,9 +75,9 @@ enum pwm_polarity {
 };
 
 enum {
-	PWMF_REQUESTED = 1 << 0,
-	PWMF_ENABLED = 1 << 1,
-	PWMF_EXPORTED = 1 << 2,
+	PWMF_REQUESTED = BIT(0),
+	PWMF_ENABLED = BIT(1),
+	PWMF_EXPORTED = BIT(2),
 };
 
 /**
-- 
2.6.1

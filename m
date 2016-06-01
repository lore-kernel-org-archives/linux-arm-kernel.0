From: jens.wiklander@linaro.org (Jens Wiklander)
Date: Wed,  1 Jun 2016 14:49:21 +0200
Subject: [PATCH] include/linux/arm-smccc.h: avoid sign extension problem
Message-ID: <1464785361-20038-1-git-send-email-jens.wiklander@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Prior to this patch the ARM_SMCCC_FAST_CALL constant was of a signed
type causing unwanted sign extension. This patch explicitly selects an
unsigned type for the constant.

Reported-by: Saksham Jain <sakjain92@gmail.com>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 include/linux/arm-smccc.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
index b5abfda..699c0d8 100644
--- a/include/linux/arm-smccc.h
+++ b/include/linux/arm-smccc.h
@@ -23,8 +23,9 @@
  * http://infocenter.arm.com/help/topic/com.arm.doc.den0028a/index.html
  */
 
-#define ARM_SMCCC_STD_CALL		0
-#define ARM_SMCCC_FAST_CALL		1
+/* This constant is shifted by 31, make sure it's of an unsigned type */
+#define ARM_SMCCC_STD_CALL		0UL
+#define ARM_SMCCC_FAST_CALL		1UL
 #define ARM_SMCCC_TYPE_SHIFT		31
 
 #define ARM_SMCCC_SMC_32		0
-- 
1.9.1

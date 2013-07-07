From: yadi.brar@samsung.com (Yadwinder Singh Brar)
Date: Sun, 07 Jul 2013 17:14:22 +0530
Subject: [PATCH 3/3] mfd: s2mps11: Remove clocks from regulators list
In-Reply-To: <1373197462-4033-1-git-send-email-yadi.brar@samsung.com>
References: <1373197462-4033-1-git-send-email-yadi.brar@samsung.com>
Message-ID: <1373197462-4033-4-git-send-email-yadi.brar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since these are fixed rate clocks which are registered with common clock
framework so remove these from list of regulators which were unnecessarily
incrementing the count(S2MPS11_REGULATOR_MAX) of regulators.

Signed-off-by: Yadwinder Singh Brar <yadi.brar@samsung.com>
---
 include/linux/mfd/samsung/s2mps11.h |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/include/linux/mfd/samsung/s2mps11.h b/include/linux/mfd/samsung/s2mps11.h
index d0d52ea..b3ddf98 100644
--- a/include/linux/mfd/samsung/s2mps11.h
+++ b/include/linux/mfd/samsung/s2mps11.h
@@ -167,11 +167,8 @@ enum s2mps11_regulators {
 	S2MPS11_BUCK8,
 	S2MPS11_BUCK9,
 	S2MPS11_BUCK10,
-	S2MPS11_AP_EN32KHZ,
-	S2MPS11_CP_EN32KHZ,
-	S2MPS11_BT_EN32KHZ,
 
-	S2MPS11_REG_MAX,
+	S2MPS11_REGULATOR_MAX,
 };
 
 #define S2MPS11_BUCK_MIN1	600000
@@ -203,6 +200,5 @@ enum s2mps11_regulators {
 #define S2MPS11_BUCK4_RAMP_EN_SHIFT	1
 #define S2MPS11_BUCK6_RAMP_EN_SHIFT	0
 #define S2MPS11_PMIC_EN_SHIFT	6
-#define S2MPS11_REGULATOR_MAX (S2MPS11_REG_MAX - 3)
 
 #endif /*  __LINUX_MFD_S2MPS11_H */
-- 
1.7.0.4

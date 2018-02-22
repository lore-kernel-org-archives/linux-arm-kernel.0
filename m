From: claudiu.beznea@microchip.com (Claudiu Beznea)
Date: Thu, 22 Feb 2018 14:01:19 +0200
Subject: [PATCH v3 08/10] pwm: add push-pull mode support
In-Reply-To: <1519300881-8136-1-git-send-email-claudiu.beznea@microchip.com>
References: <1519300881-8136-1-git-send-email-claudiu.beznea@microchip.com>
Message-ID: <1519300881-8136-9-git-send-email-claudiu.beznea@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add push-pull mode support. In push-pull mode the channels' outputs have
same polarities and the edges are complementary delayed for one period.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 include/linux/pwm.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 0ba416ab2772..765d760ef82d 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -29,11 +29,14 @@ enum pwm_polarity {
  * PWM modes
  * @PWM_MODE_NORMAL_BIT: PWM has one output
  * @PWM_MODE_COMPLEMENTARY_BIT: PWM has 2 outputs with opposite polarities
+ * @PWM_MODE_PUSH_PULL_BIT: PWM has 2 outputs with same polarities and the edges
+ * are complementary delayed for one period
  * @PWM_MODE_CNT: PWM modes count
  */
 enum {
 	PWM_MODE_NORMAL_BIT,
 	PWM_MODE_COMPLEMENTARY_BIT,
+	PWM_MODE_PUSH_PULL_BIT,
 	PWM_MODE_CNT,
 };
 
@@ -481,7 +484,11 @@ static inline bool pwm_caps_valid(struct pwm_caps caps)
 
 static inline const char * const pwm_mode_desc(unsigned long mode)
 {
-	static const char * const modes[] = { "normal", "complementary"	};
+	static const char * const modes[] = {
+		"normal",
+		"complementary",
+		"push-pull",
+	};
 
 	if (!pwm_mode_valid(mode))
 		return "invalid";
-- 
2.7.4

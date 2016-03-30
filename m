From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 30 Mar 2016 22:03:55 +0200
Subject: [PATCH v5 32/46] pwm: deprecate pwm_config(),
 pwm_enable() and pwm_disable()
In-Reply-To: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1459368249-13241-33-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Prefix those function as deprecated to encourage all existing users to
switch to pwm_apply_state().

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 include/linux/pwm.h | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 4aad4eb..9bac10f 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -225,8 +225,8 @@ int pwm_apply_state(struct pwm_device *pwm, struct pwm_state *state);
  *
  * Returns: 0 on success or a negative error code on failure.
  */
-static inline int pwm_config(struct pwm_device *pwm, int duty_ns,
-			     int period_ns)
+static inline int __deprecated pwm_config(struct pwm_device *pwm, int duty_ns,
+					  int period_ns)
 {
 	struct pwm_state pstate;
 
@@ -252,8 +252,8 @@ static inline int pwm_config(struct pwm_device *pwm, int duty_ns,
  *
  * Returns: 0 on success or a negative error code on failure.
  */
-static inline int pwm_set_polarity(struct pwm_device *pwm,
-				   enum pwm_polarity polarity)
+static inline int __deprecated pwm_set_polarity(struct pwm_device *pwm,
+						enum pwm_polarity polarity)
 {
 	struct pwm_state pstate;
 
@@ -284,7 +284,7 @@ static inline int pwm_set_polarity(struct pwm_device *pwm,
  *
  * Returns: 0 on success or a negative error code on failure.
  */
-static inline int pwm_enable(struct pwm_device *pwm)
+static inline int __deprecated pwm_enable(struct pwm_device *pwm)
 {
 	struct pwm_state pstate;
 
@@ -303,7 +303,7 @@ static inline int pwm_enable(struct pwm_device *pwm)
  * pwm_disable() - stop a PWM output toggling
  * @pwm: PWM device
  */
-static inline void pwm_disable(struct pwm_device *pwm)
+static inline void __deprecated pwm_disable(struct pwm_device *pwm)
 {
 	struct pwm_state pstate;
 
@@ -360,24 +360,24 @@ static inline int pwm_apply_state(struct pwm_device *pwm,
 	return -ENOTSUPP;
 }
 
-static inline int pwm_config(struct pwm_device *pwm, int duty_ns,
-			     int period_ns)
+static inline int __deprecated pwm_config(struct pwm_device *pwm, int duty_ns,
+					  int period_ns)
 {
 	return -EINVAL;
 }
 
-static inline int pwm_set_polarity(struct pwm_device *pwm,
-				   enum pwm_polarity polarity)
+static inline int __deprecated pwm_set_polarity(struct pwm_device *pwm,
+						enum pwm_polarity polarity)
 {
 	return -ENOTSUPP;
 }
 
-static inline int pwm_enable(struct pwm_device *pwm)
+static inline int __deprecated pwm_enable(struct pwm_device *pwm)
 {
 	return -EINVAL;
 }
 
-static inline void pwm_disable(struct pwm_device *pwm)
+static inline void __deprecated pwm_disable(struct pwm_device *pwm)
 {
 }
 
-- 
2.5.0

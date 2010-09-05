From: mark.brown314@gmail.com (Mark F. Brown)
Date: Sun,  5 Sep 2010 11:33:10 -0400
Subject: [PATCH] ARM: pxa27x_keypad: added a comment to explain
	clear_wakeup_event callback
Message-ID: <1283700790-3558-1-git-send-email-mark.brown314@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Mark F. Brown <mark.brown314@gmail.com>
---
 arch/arm/plat-pxa/include/plat/pxa27x_keypad.h |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-pxa/include/plat/pxa27x_keypad.h b/arch/arm/plat-pxa/include/plat/pxa27x_keypad.h
index 73dacda..abcc36e 100644
--- a/arch/arm/plat-pxa/include/plat/pxa27x_keypad.h
+++ b/arch/arm/plat-pxa/include/plat/pxa27x_keypad.h
@@ -25,6 +25,13 @@
  *
  * 4. matrix key and direct key will use the same debounce_interval by
  *    default, which should be sufficient in most cases
+ *
+ * pxa168 keypad platform specific parameter
+ *
+ * NOTE:
+ * clear_wakeup_event callback is a workaround required to clear the
+ * keypad interrupt. The keypad wake must be cleared in addition to
+ * reading the MI/DI bits in the KPC register.
  */
 struct pxa27x_keypad_platform_data {
 
@@ -52,6 +59,8 @@ struct pxa27x_keypad_platform_data {
 
 	/* key debounce interval */
 	unsigned int	debounce_interval;
+
+	/* clear wakeup event requirement for pxa168 */
 	void		(*clear_wakeup_event)(void);
 };
 
-- 
1.7.0.4

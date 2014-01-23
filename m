From: wangyijing@huawei.com (Yijing Wang)
Date: Thu, 23 Jan 2014 15:12:27 +0800
Subject: [PATCH 1/2] clocksource: Remove outdated comments
Message-ID: <1390461147-36256-1-git-send-email-wangyijing@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

clocksource_register() and __clocksource_register_scale()
always return 0, so the comment is just pointless, it's
outdated, remove it.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 kernel/time/clocksource.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index ba3e502..9951575 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -779,8 +779,6 @@ EXPORT_SYMBOL_GPL(__clocksource_updatefreq_scale);
  * @scale:	Scale factor multiplied against freq to get clocksource hz
  * @freq:	clocksource frequency (cycles per second) divided by scale
  *
- * Returns -EBUSY if registration fails, zero otherwise.
- *
  * This *SHOULD NOT* be called directly! Please use the
  * clocksource_register_hz() or clocksource_register_khz helper functions.
  */
@@ -805,7 +803,6 @@ EXPORT_SYMBOL_GPL(__clocksource_register_scale);
  * clocksource_register - Used to install new clocksources
  * @cs:		clocksource to be registered
  *
- * Returns -EBUSY if registration fails, zero otherwise.
  */
 int clocksource_register(struct clocksource *cs)
 {
-- 
1.7.1

From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 30 Jul 2012 18:38:33 +0200
Subject: [PATCH 1/2] pinctrl: use ERR_CAST instead of ERR_PTR(PTR_ERR(...))
Message-ID: <1343666314-18070-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This doesn't change semantics, just looks nicer.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 include/linux/pinctrl/consumer.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/pinctrl/consumer.h b/include/linux/pinctrl/consumer.h
index 6dd96fb..5431f26 100644
--- a/include/linux/pinctrl/consumer.h
+++ b/include/linux/pinctrl/consumer.h
@@ -139,7 +139,7 @@ static inline struct pinctrl * __must_check devm_pinctrl_get_select(
 	s = pinctrl_lookup_state(p, name);
 	if (IS_ERR(s)) {
 		devm_pinctrl_put(p);
-		return ERR_PTR(PTR_ERR(s));
+		return ERR_CAST(s);
 	}
 
 	ret = pinctrl_select_state(p, s);
-- 
1.7.10.4

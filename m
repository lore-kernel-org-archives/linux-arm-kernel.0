From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 16 Feb 2011 18:23:13 +0100
Subject: [PATCH] ARM: reenable DEBUG_SECTION_MISMATCH
Message-ID: <1297876993-4146-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For 2.6.38-rc4-git9 only 29 out of 133 defconfigs still produce section
mismatches.  These defconfigs produce 55 mismatches (weighted sum, so
maybe less uniq mismatches).

This is in my opinion enough to start scaring people about the remaining
problems.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 lib/Kconfig.debug |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 3967c23..1130dd4 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -102,7 +102,7 @@ config HEADERS_CHECK
 
 config DEBUG_SECTION_MISMATCH
 	bool "Enable full Section mismatch analysis"
-	depends on UNDEFINED || (BLACKFIN)
+	depends on ARM || BLACKFIN
 	default y
 	# This option is on purpose disabled for now.
 	# It will be enabled when we are down to a reasonable number
-- 
1.7.2.3

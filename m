From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri, 18 Feb 2011 21:47:20 +0100
Subject: [PATCH] kbuild: reenable section mismatch analysis
In-Reply-To: <20110216200734.GA25184@merkur.ravnborg.org>
References: <20110216200734.GA25184@merkur.ravnborg.org>
Message-ID: <1298062040-2774-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This was disabled in commit

	e5f95c8 (kbuild: print only total number of section mismatces found)

because there were too many warnings.  Now we're down to a reasonable
number again, so we start scaring people with the details.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 lib/Kconfig.debug |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 2b97418..0f77ed1 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -102,11 +102,7 @@ config HEADERS_CHECK
 
 config DEBUG_SECTION_MISMATCH
 	bool "Enable full Section mismatch analysis"
-	depends on UNDEFINED || (BLACKFIN)
 	default y
-	# This option is on purpose disabled for now.
-	# It will be enabled when we are down to a reasonable number
-	# of section mismatch warnings (< 10 for an allyesconfig build)
 	help
 	  The section mismatch analysis checks if there are illegal
 	  references from one section to another section.
-- 
1.7.2.3

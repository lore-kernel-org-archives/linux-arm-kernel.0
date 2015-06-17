From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Wed, 17 Jun 2015 10:38:50 +0200
Subject: [PATCH v2 1/7] Revert "staging: board: disable as it breaks the build"
In-Reply-To: <1434530336-15073-1-git-send-email-geert+renesas@glider.be>
References: <1434530336-15073-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1434530336-15073-2-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reverts commit d13778d537a0ed6115d2a79a942af999cfb8eec6.

Commit 13c11072536f2613 ("staging:board: remove unnecessary function")
fixed the build of drivers/staging/board/board.c.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
---
v2:
  - Add Reviewed-by.
---
 drivers/staging/board/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/board/Kconfig b/drivers/staging/board/Kconfig
index 0a89ad16371f7ded..b8ee81840666ad35 100644
--- a/drivers/staging/board/Kconfig
+++ b/drivers/staging/board/Kconfig
@@ -1,7 +1,6 @@
 config STAGING_BOARD
 	bool "Staging Board Support"
 	depends on OF_ADDRESS
-	depends on BROKEN
 	help
 	  Select to enable per-board staging support code.
 
-- 
1.9.1

From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Sat, 29 Nov 2014 19:31:36 +0100
Subject: [PATCH] drivers: kconfig: fix double include
Message-ID: <1417285896-8587-1-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

drivers/Kconfig sources drivers/soc/Kconfig twice.
Remove the last include.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 drivers/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/Kconfig b/drivers/Kconfig
index 694d5a70d6ce..2683e633c027 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -150,8 +150,6 @@ source "drivers/remoteproc/Kconfig"
 
 source "drivers/rpmsg/Kconfig"
 
-source "drivers/soc/Kconfig"
-
 source "drivers/devfreq/Kconfig"
 
 source "drivers/extcon/Kconfig"
-- 
2.1.3
